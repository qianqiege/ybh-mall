class Product < ApplicationRecord
  LED_AWAY_CATEGORY = { '1' => 'A类产品', '2' => 'B类产品', '3' => 'C类产品' }.freeze

  include ImageConcern
  has_many :line_items
  has_many :member_equities
  has_many :product_images
  has_many :purchase_order_items
  has_many :shop_order_items
  has_many :stock_out_items
  has_many :day_deal_items
  has_many :month_deal_items
  has_many :sale_products
  has_many :stocks
  belongs_to :activity
  belongs_to :contents_category
  before_destroy :ensure_not_referenced_by_any_line_item

  validates :name, :now_product_price, :image, :desc, presence: true
  validates :now_product_price, numericality: { greater_than_or_equal_to: 0.01 }
  # validates :shop_count, :lock_shop_count, numericality: { only_integer: true,  greater_than_or_equal_to: 0 }
  validates :shop_count, numericality: { only_integer: true,  greater_than_or_equal_to: 0 }

  def reduce_shop_count(quantity)
    self.shop_count -= quantity
    self.lock_shop_count += quantity
    self.save validate: false
  end

  def display_name
    "#{self.name}-----#{self.product_sort}-----#{self.packaging}"
  end

  def back_shop_count(quantity)
    self.shop_count += quantity
    self.lock_shop_count -= quantity
    self.save!
  end

  def pay_reduce_shop_count(quantity)
    self.lock_shop_count -= quantity
    self.save!
  end
  def category
    LED_AWAY_CATEGORY[self.led_away_category.to_s]
  end

  private

  # 如果这个商品被添加进购物车，这个商品要必须等到清空购物车后才能被删除
  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line Items present')
      throw :abort
    end
  end
end
