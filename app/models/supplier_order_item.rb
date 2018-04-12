class SupplierOrderItem < ApplicationRecord
  belongs_to :supplier_order
  belongs_to :supplier
  belongs_to :product

  validates :product_id, presence: true
  validates :order_count, presence: true
  validates :prices, presence: true
end
