class MembershipCard < ApplicationRecord
  include ImageConcern
  belongs_to :member_club
  belongs_to :serve
  # 房产
  belongs_to :house_poperty
  # 股权
  belongs_to :stock_right
  # 会员权益
  has_many :member_equities
  # 会员档案
  belongs_to :member_record
end
