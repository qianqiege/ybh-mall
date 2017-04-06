class ScoinAccount < ApplicationRecord
  has_paper_trail

  belongs_to :user
  has_many :scoin_account_order_relations, dependent: :destroy
  has_many :orders, through: :scoin_account_order_relations, dependent: :destroy

  has_many :scoin_records, dependent: :destroy, as: :account

  accepts_nested_attributes_for :scoin_records

  validates :user_id, :account, presence: true, uniqueness: true

  def name
    account
  end

  # 计算每天需要自动赠送的S货币
  def calculate_number
    scoin_records.includes(:coin_type).ongoing.each do |record|
      self.number += record.coin_type.everyday
    end
    update_attributes(number: self.number)
  end

end
