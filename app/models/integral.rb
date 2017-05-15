class Integral < ApplicationRecord
  has_paper_trail
  belongs_to :user
  after_create :update_number

  validates :locking,:available,:exchange,:not_cash,:cash,:not_exchange,:not_appreciation,:appreciation, numericality: { greater_than_or_equal_to: -1 }
  validates :user_id, uniqueness: true

  def update_number
    if self.locking.nil? && self.available.nil? && self.appreciation.nil? && self.not_appreciation.nil? && self.not_exchange.nil? && self.not_cash.nil? && self.cash.nil? && self.exchange.nil?
      self.available = 0
      self.exchange = 0
      self.locking = 0
      self.cash = 0
      self.not_cash = 0
      self.not_exchange = 0
      self.not_appreciation = 0
      self.appreciation = 0
    end
  end
end
