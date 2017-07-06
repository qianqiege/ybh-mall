class UserIdataSubscribe < ApplicationRecord
	belongs_to :user

	serialize :list, Array


	@@list = nil

	def self.get_list
		@@list
	end

	def self.set_list(list)
		@@list = list
	end
end
