class SpdStock < ApplicationRecord
  belongs_to :warehouse
  belongs_to :product
  has_many :spd_stock_batches

end
