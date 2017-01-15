class ScoinAccountOrderRelation < ApplicationRecord
  DEFAULT_CALCULATE_DAY = 365

  belongs_to :order
  belongs_to :scoin_account
  validates :order_id, :scoin_account_id, presence: true
  validates :order_id , uniqueness: { scope: :scoin_account_id,
      message: "一个订单只能绑定一个用户,请不要重复绑定" }
  after_create :add_scoin_records

  private

  # 绑定订单时
  # 1. 自动创建 scoin_records
  # 2. 自动赠送第一天记录
  # 3. 包数量不足，不增加赠送S币记录
  def add_scoin_records
    rules = order.activity.activity_rules.match_rules(order.price)
    scoin_records_attributes = []
    rules.map do |rule|
      limit_count = rule.scoin_type.limit_count
      if(limit_count > 0)
        scoin_account.number ||= 0
        scoin_account.number += rule.scoin_type.once
        scoin_records_attributes << {
          scoin_type_id: rule.scoin_type_id,
          start_at: 1.day.from_now,
          end_at: (DEFAULT_CALCULATE_DAY + 1).day.from_now
        }
        rule.scoin_type.update_attributes(limit_count: (limit_count - 1))
      end
    end
    scoin_account.scoin_records_attributes = scoin_records_attributes
    scoin_account.save
  end

end
