class MemberRank < ApplicationRecord
  belongs_to :vip_type
  has_many :member_ranks
end
