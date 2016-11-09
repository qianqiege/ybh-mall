class Setmeal < ApplicationRecord
  include ImageConcern
  has_many :VipCards
  has_many :Serve, through: :SetMealServeRelations
  has_many :SetMealServeRelations
end
