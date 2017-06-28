class RegularReport < ApplicationRecord
	include RecordableConcern
	belongs_to :user
end
