class SpdBusinessItem < ApplicationRecord
  belongs_to :product
  belongs_to :spd_business
  has_many :spd_business_batches
  accepts_nested_attributes_for :spd_business_batches
end
