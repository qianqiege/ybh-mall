class CashRecord < ApplicationRecord
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
      wallet.not_cash += self.number
      wallet.save
    end
  end

end
