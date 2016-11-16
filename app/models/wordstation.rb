class Wordstation < ApplicationRecord
  belongs_to :service_staff
  has_many :spine_builds
end
