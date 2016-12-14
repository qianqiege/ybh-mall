class User < ApplicationRecord
  has_one :member_record
  has_one :wechat_user
  has_many :member_clubs
  # has_many :subscribe 预约
  has_one :order
  has_many :examine_records
end
