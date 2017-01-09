class HealthProgram < ApplicationRecord
  validates :name,:number,:only_number,:coding, presence: true
  validates :identity_card , presence: true ,length: { is: 18 }
  has_many :product_programs
end
