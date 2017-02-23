class BloodPressure < ApplicationRecord
  belongs_to :examine_record
  belongs_to :user
  validates :diastolic_pressure, presence: true
  validates :systolic_pressure, presence: true
end
