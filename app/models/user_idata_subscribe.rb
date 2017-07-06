class UserIdataSubscribe < ApplicationRecord
	belongs_to :user

	serialize :list, Array

end
