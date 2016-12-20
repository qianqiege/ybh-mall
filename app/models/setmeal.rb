class Setmeal < ApplicationRecord
  include ImageConcern
  has_many :member_clubs
  has_many :serve, through: :set_meal_serve_relations
  has_many :set_meal_serve_relations
end
