class Serve < ApplicationRecord
  has_many :membership_cards
  has_many :setmeals, through: :set_meal_serve_relations
  has_many :set_meal_serve_relations
  has_many :reservation_records
  has_many :spine_builds

  def name
    serve_name    
  end
end
