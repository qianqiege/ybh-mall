class MemberClub < ApplicationRecord
  include ImageConcern
  belongs_to :vip_type
  has_many :membership_cards
  belongs_to :setmeal
end
