class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  belongs_to :order

  validates :product, :cart, presence: true

  # 需要重新定义，有些会员是有折扣的
  def price
    product.now_product_price
  end

  def total_price
    price * quantity
  end

  def move_to_order(order_id)
    self.unit_price = self.price
    self.in_cart = false
    self.order_id = order_id
    self.save validate: false
  end
end
