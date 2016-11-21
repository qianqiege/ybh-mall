class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  belongs_to :order

  validates :product, :cart, presence: true
  validate :check_quantity, on: [:create, :update]
  validates :quantity, numericality: { only_integer: true,  greater_than_or_equal_to: 0 }

  # 需要重新定义，有些会员是有折扣的
  def price
    product.now_product_price
  end

  def total_price
    price * quantity
  end

  def real_total_price
    price * real_quantity
  end

  def move_to_order(order_id)
    self.unit_price = self.price
    self.in_cart = false
    self.order_id = order_id
    self.save validate: false
  end

  # 商品最大购买数目
  def real_quantity
    if quantity <= product.shop_count
      quantity
    else
      product.shop_count
    end
  end

  private

  def check_quantity
    if product.shop_count == 0
      errors.add(:quantity, "没有库存了")
      return false
    end

    if quantity > product.shop_count
      errors.add(:quantity, "库存不够，最多只能购买#{product.shop_count}件商品，需要等等再来，或重新刷新页面")
      return false
    end
  end
end
