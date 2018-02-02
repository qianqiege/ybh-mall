class Plan < ApplicationRecord
  before_save :change_number
  before_create :generate_number
  after_create :plan_active

  belongs_to :user
  has_many :parallel_shops
  has_many :money_details

  has_many :partners, class_name: "Plan", foreign_key: "invite_plan_id"
  belongs_to :invite_plan, class_name: "Plan"
  belongs_to :plan_rule
  belongs_to :sharing_plan

  # serialize :partner_ids, Array
  include AASM
  aasm column: :status do
    #付款失败
    state :failing, initial: true

    #付款成功
    state :success

    event :pay do
      transitions from: :failing, to: :success

      after do
        self.active = true
        self.save
      end
    end
  end

  def change_number
    self.code = Plan.generate_number
  end

  def self.generate_number
    loop do
      salt = rand(99999..999999)
      coding = "PL"+"#{Date.current.to_s(:number)}#{salt}"
      break coding unless self.exists?(number: coding)
    end
  end

  def name
    "#{self.user.name} -- #{self.code}"
  end

  def fast_pay
    @fast_pay ||= Sdk::FastPay.new(self)
  end

  def generate_number
    begin
      salt = rand(99999..999999)
      self.number = "#{Time.current.to_s(:number)}#{salt}"
    end while self.class.exists?(number: number)
  end

  def plan_active
    up_plan = self.invite_plan #上级的计划
    need_count = self.plan_rule.sharing_plan.invite_count #所属计划 需要 邀请的人数
    actual_count = self.partners.count #所属计划 实际 邀请的人数
    if need_count == 9
      # 有上级计划
      if up_plan
        up_need_count = up_plan.plan_rule.sharing_plan.invite_count #上级计划 需要 邀请的人数
        up_actual_count = up_plan.partners.count #上级计划 实际 邀请的人数
        logger.info("==================#{up_need_count}=========================")
        logger.info("==================#{up_actual_count}=========================")
        if up_actual_count >= up_need_count
          logger.info("==================有邀请人更新授权=========================")
          Plan.where(invite_plan_id: up_plan.id).update_all(active: true)
          self.update(active: true)
        end
      end
      # 无上级计划
      if actual_count >= need_count
        logger.info("==================无邀请人更新授权=========================")
        Plan.where(invite_plan_id: self.id).update_all(active: true)
        self.update(active: true)
      end
    else
      logger.info("==================199以外更新授权=========================")
      self.update(active: true)
    end
  end
end
