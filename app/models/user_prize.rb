class UserPrize < ApplicationRecord
  belongs_to :user
  belongs_to :lottery_prize
end
