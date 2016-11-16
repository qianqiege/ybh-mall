class SpineBuild < ApplicationRecord
  belongs_to :workstation
  belongs_to :rank
  belongs_to :serve
end
