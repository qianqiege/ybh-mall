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

  # 商品金额
  # 下架的商品不计算
  def total_price
    product.is_show ? price * real_quantity : 0
  end

  def move_to_order(order_id)
    self.unit_price = self.price
    self.in_cart = false
    self.order_id = order_id
    self.save validate: false

    self.product.reduce_shop_count(self.quantity)
  end

  # 商品最大购买数目
  # 下架的商品不能购买
  def real_quantity
    if product.is_show
      quantity <= product.shop_count ? quantity : product.shop_count
    else
      0
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
