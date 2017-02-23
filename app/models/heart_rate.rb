class HeartRate < ApplicationRecord
  belongs_to :examine_record
  belongs_to :user
  validates :value, presence: true
end
