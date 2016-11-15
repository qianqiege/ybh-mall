class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  # 需要重新定义，有些会员是有折扣的
  def total_price
    product.price * quantity
  end
end
