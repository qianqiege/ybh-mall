class Shop < ApplicationRecord
	belongs_to :user
	has_many :shop_propaganda_images, dependent: :destroy
	has_many :shop_features

	mount_uploader :license_image, ImageUploader
	mount_uploader :user_image, ImageUploader

	include AASM
	aasm column: :state do
		state :pending, :initial => true
		state :dealing
		state :dealed
		state :not

		# event :address_event do
		# 	transitions from: :pending, to: :dealing
		# 	after do
		# 		self.save
		# 	end
		# end

		# event :identity_pass do
		# 	transitions from: :dealing, to: :dealed
		# 	after do
		# 		self.save
		# 	end
		# end

		# event :address_not_pass do
		# 	transitions from: :pending, to: :not
		# 	after do
		# 		self.desc = "地址不符合"
		# 		self.save
		# 	end
		# end

		# event :identity_not_pass do
		# 	transitions from: :dealing, to: :not
		# 	after do
		# 		self.desc = "身份不符合"
		# 		self.save
		# 	end
		# end
	end



end
