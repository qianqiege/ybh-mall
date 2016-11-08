class User < ApplicationRecord
  has_one :VipRecord
  has_one :WechatUser
  has_many :VipLv
  # has_many :Subscribe 预约
  has_one :Order
end
