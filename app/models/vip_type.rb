class VipType < ApplicationRecord
  include ImageConcern
  has_many :member_clubs
end
