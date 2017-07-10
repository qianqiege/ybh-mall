class ProductImage < ApplicationRecord
  include ImageConcern
  belongs_to :product
end
