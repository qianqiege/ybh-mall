class LotteryPrize < ApplicationRecord
  include ImageConcern
  has_many :user_prizes
end
