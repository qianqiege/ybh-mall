class SupplierOrder < ApplicationRecord
  has_many :supplier_order_items
  belongs_to :supplier
  accepts_nested_attributes_for :supplier_order_items, allow_destroy: true
end
