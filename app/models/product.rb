class Product < ApplicationRecord
  include ImageConcern
  has_many :line_items
  validates :name, :now_product_price, :image, :desc, presence: true
  validates :now_product_price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :shop_count, numericality: { only_integer: true }
end
