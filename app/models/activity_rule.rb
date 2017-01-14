class ActivityRule < ApplicationRecord
  belongs_to :activity
  belongs_to :scoin_type

  validates :activity_id, :scoin_type_id, :max, :min, presence: true
  scope :match_rules, -> (price) { where('(min <= ? AND max >= ?)', price, price) }
end
