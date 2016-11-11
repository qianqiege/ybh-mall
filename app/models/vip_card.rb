class VipCard < ApplicationRecord
  belongs_to :VipLv
  belongs_to :Setmeal
  belongs_to :Serve
  belongs_to :HousePoperty
  belongs_to :StockRight
end
