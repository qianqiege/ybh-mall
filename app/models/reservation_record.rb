class ReservationRecord < ApplicationRecord
  attr_accessor :rank_id, :work_id

  belongs_to :spine_build
end
# class="weui-select"
