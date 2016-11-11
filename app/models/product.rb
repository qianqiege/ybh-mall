class Product < ApplicationRecord
  include ImageConcern
  belongs_to :order_item
  belongs_to :shopping
end
