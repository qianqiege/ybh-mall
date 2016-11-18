class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  validates :product, :cart, presence: true

  # 需要重新定义，有些会员是有折扣的
  def price
    product.now_product_price
  end

  def total_price
    price * quantity
  end
end
