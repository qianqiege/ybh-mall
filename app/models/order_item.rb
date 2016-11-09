class OrderItem < ApplicationRecord
  has_many :Products
  has_one :Payment
  has_one :ReceiverInfo
  has_one :SenderInfo
  belongs_to :Order
end
