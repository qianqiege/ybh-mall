class UserIdataSubscribe < ApplicationRecord
	belongs_to :user

	serialize :list, Array


	@@list = nil

	def get_list
		@@list
	end

	def set_list(list)
		@@list = list
	end
end
