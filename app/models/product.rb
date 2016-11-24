class Product < ApplicationRecord
  include ImageConcern
  has_many :line_items
  has_many :member_equities

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :name, :now_product_price, :image, :desc, presence: true
  validates :now_product_price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :shop_count, numericality: { only_integer: true,  greater_than_or_equal_to: 0 }

  private

  # 如果这个商品被添加进购物车，这个商品要必须等到清空购物车后才能被删除
  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line Items present')
      throw :abort
    end
  end
end
