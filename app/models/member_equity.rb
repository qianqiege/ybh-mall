class MemberEquity < ApplicationRecord
  belongs_to :serve
  belongs_to :product
  belongs_to :membership_card
end
