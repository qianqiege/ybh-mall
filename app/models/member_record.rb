class MemberRecord < ApplicationRecord
  belongs_to :user
  has_many :membership_cards
end
