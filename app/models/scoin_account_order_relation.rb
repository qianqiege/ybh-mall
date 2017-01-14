class ScoinAccountOrderRelation < ApplicationRecord
  DEFAULT_CALCULATE_DAY = 365

  belongs_to :order
  belongs_to :scoin_account
  validates :order_id, :scoin_account_id, presence: true
  after_create :add_scoin_records

  private

  # 绑定订单时
  # 1. 自动创建 scoin_records
  # 2. 自动赠送第一天记录
  # TODO: 超过限定包不赠送
  def add_scoin_records
    rules = order.activity.activity_rules.match_rules(order.price)
    scoin_account.scoin_records_attributes = rules.map do |rule|
      scoin_account.number ||= 0
      scoin_account.number += rule.scoin_type.once
      {
        scoin_type_id: rule.scoin_type_id,
        start_at: 1.day.from_now,
        end_at: (DEFAULT_CALCULATE_DAY + 1).day.from_now
      }
    end
    scoin_account.save
  end

end
