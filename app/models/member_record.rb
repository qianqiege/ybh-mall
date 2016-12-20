class MemberRecord < ApplicationRecord
  belongs_to :user
  belongs_to :membership_card
end
