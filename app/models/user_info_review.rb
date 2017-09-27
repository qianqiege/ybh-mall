class UserInfoReview < ApplicationRecord
	belongs_to :user
	validates :identity, inclusion: { in: %w(family_doctor family_health_manager helath_manager user) }


	include AASM
	aasm column: :state do
		state :pending, :initial => true
		state :dealing
		state :dealed
		state :not

		event :address_event do
			transitions from: :pending, to: :dealing
			after do
				self.save
			end
		end

		event :identity_pass do
			transitions from: :dealing, to: :dealed
			after do
				self.save
			end
		end

		event :address_not_pass do
			transitions from: :pending, to: :not
			after do
				self.desc = "地址不符合"
				self.save
			end
		end

		event :identity_not_pass do
			transitions from: :dealing, to: :not
			after do
				self.desc = "身份不符合"
				self.save
			end
		end
	end

	def display_work_detail
	   "#{ChinaCity.get(work_province)} #{ChinaCity.get(work_city)} #{ChinaCity.get(work_street)}"
	end

	def display_resident_detail
		"#{ChinaCity.get(resident_province)} #{ChinaCity.get(resident_city)} #{ChinaCity.get(resident_street)}"
	end

	def identity_name
		case self.identity
			when "family_doctor"
				"家庭医生"
			when "family_health_manager"
				"家庭健康管理师"
			when "helath_manager"
				"健康管理师"
			when "user"
				"用户"
		end
	end

	def get_state
		case state
		when "pending"
			"待审核"
		when "dealed"
			"已通过审核"
		when "dealing"
			"地址审核通过，等待身份审核"
		when "not"
			"审核未通过," + desc
		end
	end
end
