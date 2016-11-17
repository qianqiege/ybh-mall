class Rank < ApplicationRecord
  has_many :spine_builds
  def name
    level
  end
end
