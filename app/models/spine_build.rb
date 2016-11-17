class SpineBuild < ApplicationRecord
  belongs_to :workstation
  belongs_to :rank
  belongs_to :serve
  has_many :reservation_records
end
