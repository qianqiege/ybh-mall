class User < ApplicationRecord
  has_one :vip_record
  has_one :wechat_user
  has_many :vip_lv
  # has_many :subscribe 预约
  has_one :order
end
