class MembershipCard < ApplicationRecord
  belongs_to :member_rank
  belongs_to :setmeal
  belongs_to :serve
  belongs_to :house_poperty
  belongs_to :stock_right
end
