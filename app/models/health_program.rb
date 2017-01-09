class HealthProgram < ApplicationRecord
  # validates :identity_card , presence: true ,length: { is: 18 }
  has_many :product_programs
end
