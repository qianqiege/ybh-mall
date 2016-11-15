class ServiceStaff < ApplicationRecord
  has_many :reservation_record
  belongs_to :serve
end
