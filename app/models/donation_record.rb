class DonationRecord < ApplicationRecord

  belongs_to :user


  after_create :default_value
  before_create :generate_number


  include AASM
  aasm column: :status do
    #付款失败
    state :failing, initial: true

    #付款成功
    state :success

    event :pay do
      transitions from: :failing, to: :success
    end
  end

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

  def fast_pay
     @fast_pay ||= Sdk::FastPay.new(self)
  end


  def generate_number
    begin
      salt = rand(99999..999999)
      self.order_number = "#{Time.current.to_s(:number)}#{salt}"
    end while self.class.exists?(order_number: order_number)
  end

end
