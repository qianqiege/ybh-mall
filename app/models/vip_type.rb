class VipType < ApplicationRecord
  has_many :vip_lvs
  has_many :set_meals
end
