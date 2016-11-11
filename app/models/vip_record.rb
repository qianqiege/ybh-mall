class VipRecord < ApplicationRecord
  belongs_to :vip_info
  belongs_to :user
end
