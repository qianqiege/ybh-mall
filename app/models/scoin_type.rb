class ScoinType < ApplicationRecord
  has_paper_trail
  DEFAULT_CALCULATE_DAY = 365

  has_many :scoin_records
  has_one :activity_rule

  before_validation :calculate_count

  validates :name, :once, :everyday, :count, :remain_count, presence: true

  def calculate_count
    self.count = once + everyday * 365
  end
end
