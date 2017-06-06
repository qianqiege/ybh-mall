class CashRecord < ApplicationRecord

  attr_accessor :price, :trade_name
  has_paper_trail
  belongs_to :user

  before_create :update_status
  after_create :update_cash

  def update_status
    if self.status.nil?
      self.status = "系统创建"
    end
  end

  def update_cash
    wallet = Integral.find_by(user_id: user.id)
    if !wallet.nil?
      wallet.cash += self.number.to_f
      wallet.save
    end
  end


  def fast_pay
    @fast_pay ||= Sdk::FastPay.new(self)
  end
end
