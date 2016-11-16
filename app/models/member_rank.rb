class MemberRank < ApplicationRecord
  include ImageConcern
  belongs_to :vip_type
  has_many :member_ranks
end
