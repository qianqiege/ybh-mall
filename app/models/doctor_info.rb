class DoctorInfo < ApplicationRecord
	include ImageConcern
	belongs_to :shop
end
