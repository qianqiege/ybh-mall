class DonationRecord < ApplicationRecord
  after_create :default_value

  def default_value

    @integral_price = 0

    if price.nil?
      self.price = 0
      self.save
    end

    if integral.nil?
      self.integral = 0
      self.save
    else
      @integral_priceself = self.integral / 2
    end

    if cash.nil?
      self.cash = 0
      self.save
    end

    if !cash.nil? && !integral.nil? && !price.nil?
      self.count_price = price + @integral_priceself + cash
      self.save
    end
  end

end
