class SetMeal < ApplicationRecord
  belongs_to :vip_type
  has_many :vip_lvs
end
