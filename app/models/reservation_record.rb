class ReservationRecord < ApplicationRecord
  belongs_to :serve
  belongs_to :service_staff
end
