class Order < ApplicationRecord
  belongs_to :wechat_user
  belongs_to :address
  has_many :line_items, -> { where in_cart: false }, dependent: :destroy

  validates :quantity, numericality: { only_integer: true,  greater_than_or_equal_to: 1 }
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :wechat_user, :address, presence: true
end
