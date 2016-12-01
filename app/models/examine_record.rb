class ExamineRecord < ApplicationRecord
  has_many :heart_rates
  has_many :blood_glucoses
  has_many :blood_pressures
  has_many :temperatures
  has_many :weights
  belongs_to :user
end
