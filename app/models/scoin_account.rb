class ScoinAccount < ApplicationRecord
  DEFAULT_CALCULATE_DAY = 365

  belongs_to :user
  belongs_to :order
  has_many :scoin_records, dependent: :destroy
  accepts_nested_attributes_for :scoin_records

  validates :user_id, :order_id, :account, presence: true

  before_create :add_scoin_records

  def name
    account
  end

  # 计算每天需要自动赠送的S币
  def calculate_number
    scoin_records.includes(:scoin_type).ongoing.each do |record|
      self.number += record.scoin_type.everyday
    end
    update_attributes(number: self.number)
  end

  private

  # 开通账号时
  # 1. 自动创建 scoin_records
  # 2. 自动赠送第一天记录
  # TODO: 超过限定包不赠送
  def add_scoin_records
    rules = order.activity.activity_rules.match_rules(order.price)
    self.scoin_records_attributes = rules.map do |rule|
      self.number ||= 0
      self.number += rule.scoin_type.once
      {
        scoin_type_id: rule.scoin_type_id,
        start_at: 1.day.from_now,
        end_at: (DEFAULT_CALCULATE_DAY + 1).day.from_now
      }
    end
  end
end
