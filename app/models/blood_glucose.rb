class BloodGlucose < ApplicationRecord
  belongs_to :examine_record
  belongs_to :user
  validates :mens_type, presence: true
  validates :value, presence: true
end
