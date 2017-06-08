class CashRecord < ApplicationRecord

  attr_accessor :price, :trade_name
  has_paper_trail
  belongs_to :user

  before_create :update_status

  def update_status
    if self.status.nil?
      self.status = "系统创建"
    end
  end

  def fast_pay
    @fast_pay ||= Sdk::FastPay.new(self)
  end
end
