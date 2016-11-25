class MemberEquity < ApplicationRecord
  belongs_to :serve
  belongs_to :product
  belongs_to :membership_card
  validates :number_of_time,:number,:price,:membership_card_id,:remark, presence: true
end
