class OrderItem < ApplicationRecord
  has_many :products
  has_one :payment
  has_one :receiver_info
  has_one :sender_info
  belongs_to :order
end
