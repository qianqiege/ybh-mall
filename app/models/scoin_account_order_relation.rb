class ScoinAccountOrderRelation < ApplicationRecord
  has_paper_trail
  DEFAULT_CALCULATE_DAY = 365

  belongs_to :order
  belongs_to :scoin_account
  validates :order_id, :scoin_account_id, presence: true
  validates :order_id , uniqueness: { scope: :scoin_account_id,
      message: "一个订单只能绑定一个用户,请不要重复绑定" }
  before_validation :validate_order
  after_create :add_scoin_records

  private

  def validate_order
    if(order.activity.nil?)
      errors.add(:order_id, "该订单没参与任何活动")
    end

    if(order.user_id != scoin_account.user_id)
      errors.add(:order_id, "该订单不属于当前用户,无法绑定")
    end
  end

  # 绑定订单时
  # 1. 自动创建 scoin_records
  # 2. 自动赠送开通送第一次  +  第一天的
  # 3. 包数量不足，不增加赠送S货币记录
  def add_scoin_records
    rules = order.activity.activity_rules.match_rules(order.price)
    scoin_records_attributes = []
    rules.map do |rule|
      remain_count = rule.scoin_type.remain_count || 0
      present_count = rule.scoin_type.present_count || 0
      if(remain_count > 0)
        scoin_account.number ||= 0
        scoin_account.number += (rule.scoin_type.once + rule.scoin_type.everyday)
        scoin_records_attributes << {
          scoin_type_id: rule.scoin_type_id,
          start_at: 1.day.from_now,
          end_at: (DEFAULT_CALCULATE_DAY - 1).day.from_now
        }
        rule.scoin_type.update_attributes(remain_count: (remain_count - 1), present_count: (present_count + 1))
      end
    end
    scoin_account.scoin_records_attributes = scoin_records_attributes
    scoin_account.save
  end

end
