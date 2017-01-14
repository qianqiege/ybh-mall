class ScoinAccount < ApplicationRecord
  belongs_to :user
  has_many :scoin_account_order_relations, dependent: :destroy
  has_many :orders, through: :scoin_account_order_relations, dependent: :destroy

  has_many :scoin_records, dependent: :destroy
  accepts_nested_attributes_for :scoin_records

  validates :user_id, :account, presence: true

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

end
