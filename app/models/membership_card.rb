class MembershipCard < ApplicationRecord
  include ImageConcern
  belongs_to :member_club
  belongs_to :setmeal
  belongs_to :serve
  belongs_to :house_poperty
  belongs_to :stock_right
  has_many :member_equities
end
