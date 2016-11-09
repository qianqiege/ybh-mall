class Payment < ApplicationRecord
  belongs_to :Order
  belongs_to :OrderItem
end
