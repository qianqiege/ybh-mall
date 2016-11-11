class SetMealServeRelation < ApplicationRecord
  belongs_to :setmeal
  belongs_to :serve
end
