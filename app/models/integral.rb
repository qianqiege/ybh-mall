class Integral < ApplicationRecord
  has_paper_trail
  belongs_to :user

  before_create :update_number

  def update_number
    if self.locking.nil? && self.available.nil?
      self.bronze = 0
      self.silver = 0
      self.gold = 0
      self.locking = 0
    end
  end
end
