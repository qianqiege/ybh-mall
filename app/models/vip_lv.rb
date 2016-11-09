class VipLv < ApplicationRecord
  belongs_to :VipType
  has_many :VipCards
end
