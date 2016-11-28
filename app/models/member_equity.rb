class MemberEquity < ApplicationRecord
  belongs_to :serve
  belongs_to :product
  belongs_to :membership_card
  validates :price,:membership_card_id,:remark, presence: true
end
