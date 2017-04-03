class CoinType < ApplicationRecord
  has_paper_trail
  has_one :activity_rule

  validates :name, :once, :everyday, presence: true

  before_save :calculate_count

  def calculate_count
    self.count = once + everyday * 365
  end

end
