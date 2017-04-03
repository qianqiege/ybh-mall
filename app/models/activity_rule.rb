class ActivityRule < ApplicationRecord
  has_paper_trail
  belongs_to :activity
  belongs_to :coin_type

  validates :activity_id, :coin_type_id, :max, :min, presence: true
  scope :match_rules, -> (price) { where('(min <= ? AND max >= ?)', price, price) }
end
