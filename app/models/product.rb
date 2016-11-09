class Product < ApplicationRecord
  belongs_to :OrderItem
  belongs_to :Shopping
end
