class ReservationRecord < ApplicationRecord
  attr_accessor :rank_id, :work_id

  belongs_to :spine_build
  validates :spine_build, :name, presence: true
  validates :identity_card, length: { is: 18 }
end
# class="weui-select"
