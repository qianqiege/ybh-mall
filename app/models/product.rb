class Product < ApplicationRecord
  belongs_to :order_item
  belongs_to :shopping
end
