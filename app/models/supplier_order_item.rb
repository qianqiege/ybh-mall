class SupplierOrderItem < ApplicationRecord
  belongs_to :supplier_order
  belongs_to :supplier
  belongs_to :product
end
