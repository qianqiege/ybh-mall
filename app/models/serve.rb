class Serve < ApplicationRecord
  include ImageConcern
  has_many :membership_cards
  has_many :setmeals, through: :set_meal_serve_relations
  has_many :set_meal_serve_relations
  has_many :reservation_records
  has_many :service_staffs
end
