class Integral < ApplicationRecord
  has_paper_trail
  belongs_to :user

  validates :locking,:available,:exchange,numericality: { greater_than_or_equal_to: -1 }

  before_create :update_number

  def update_number
    if self.locking.nil? && self.available.nil?
      self.available = 0
      self.exchange = 0
      self.locking = 0
    end
  end
end
