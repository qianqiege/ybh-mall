class Cart < ApplicationRecord
  belongs_to :wechat_user
  belongs_to :user
  has_many :line_items, -> { where in_cart: true }

  def add_product(product, quantity)
    current_item = line_items.find_by(product_id: product.id)
    if current_item
      current_item.quantity += quantity
    else
      current_item = line_items.build(product_id: product.id, quantity: quantity)
    end
    current_item
  end

  # 商品总金额
  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

  # 目前放在购物车中的商品数量
  # 下架的商品不能被计算在总数量中
  def product_count
    line_items.to_a.sum { |item| item.product.is_show ? item.quantity : 0 }
  end

  # 目前放在购物车中的商品数量
  # 包含下架的商品
  # 此方法在生成订单时调用，用于比较
  def all_product_count
    line_items.to_a.sum { |item| item.quantity }
  end

  # 真正能够购买的商品总数量
  def real_product_count
    reload.line_items.to_a.sum { |item| item.real_quantity }
  end
end
