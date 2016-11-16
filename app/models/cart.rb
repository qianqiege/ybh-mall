class Cart < ApplicationRecord
  belongs_to :wechat_user
  has_many :line_items, dependent: :destroy

  def add_product(product, quantity)
    current_item = line_items.find_by(product_id: product.id)
    if current_item
      current_item.quantity += quantity
    else
      current_item = line_items.build(product_id: product.id)
    end
    current_item
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

  def product_count
    line_items.to_a.sum { |item| item.quantity }
  end
end
