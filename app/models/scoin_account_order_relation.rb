class ScoinAccountOrderRelation < ApplicationRecord
  has_paper_trail
  DEFAULT_CALCULATE_DAY = 365

  belongs_to :order
  belongs_to :scoin_account
  validates :order_id, :scoin_account_id, presence: true
  validates :order_id , uniqueness: { scope: :scoin_account_id,
      message: "一个订单只能绑定一个用户,请不要重复绑定" }
  before_validation :validate_order
  # after_create :add_scoin_records

  include AASM
  aasm column: :status do
    state :pending, initial: true
    state :finished

    event :done do
      transitions from: :pending, to: :finished
      after do
        add_scoin_records
      end
    end
  end

  def user_name
    order.try(:user).try(:name)
  end

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
    scoin_type_names = ""
    rules.map do |rule|
      if rule.coin_type.type == 'ScoinType'
        remain_count = rule.coin_type.remain_count || 0
        present_count = rule.coin_type.present_count || 0
        scoin_type_names += (rule.coin_type.try(:name) + ",")
        if(remain_count > 0)
          scoin_account.number ||= 0
          scoin_account.number += (rule.coin_type.once + rule.coin_type.everyday)
          scoin_records_attributes << {
            coin_type_id: rule.coin_type_id,
            start_at: 1.day.from_now,
            end_at: (DEFAULT_CALCULATE_DAY - 1).day.from_now
          }
          rule.coin_type.update_attributes(remain_count: (remain_count - 1), present_count: (present_count + 1))
        end
      end
    end
    scoin_account.scoin_records_attributes = scoin_records_attributes
    if scoin_account.state == "未开户"
      scoin_account.state = "已开户"
    end
    scoin_account.save

    # 发送短信
    phone = order.user.telphone
    if(phone && rules.count > 0)
      if Rails.env.production?
        send_params = {
          number: scoin_account.account,
          number1: scoin_account.password,
          number2: scoin_type_names
        }
        ChinaSMS.use :yunpian, password: Settings.sms_password
        ChinaSMS.to phone, send_params, tpl_id: Settings.scoin_account_tpl_id
      else
        logger.info "send sms to #{phone} with #{send_params}"
      end
    end
  end

end
