class User < ApplicationRecord
  has_one :member_record
  has_one :wechat_user
  # has_many :subscribe 预约
  has_one :order
  has_many :examine_records

  def name
    telphone
  end

  validates :telphone, uniqueness: true, presence: true, length: {is: 11}
  validates :password, presence: true, length: { in: 6..20 }
  validates :identity_card, uniqueness: true, presence: true, length: { is: 18 }
end
