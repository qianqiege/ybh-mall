class User < ApplicationRecord
  has_one :vip_record
  has_one :wechat_user
  # has_many :subscribe 预约
  has_one :order
  has_many :examine_records
end
