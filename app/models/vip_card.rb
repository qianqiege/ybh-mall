class VipCard < ApplicationRecord
  belongs_to :VipLv
  belongs_to :Setmeal
  belongs_to :Serve
  belongs_to :HouserPoperty
  belongs_to :StockRight
end
