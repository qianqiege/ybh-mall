class TemporaryDatum < ApplicationRecord
  validates :phone, presence: true, length: {is: 11}
  validates :identity_card, presence: true, length: { is: 18 }
end
