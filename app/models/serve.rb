class Serve < ApplicationRecord
  has_many :VipCards
  has_many :Setmeals, through: :SetMealServeRelations
  has_many :SetMealServeRelations
end
