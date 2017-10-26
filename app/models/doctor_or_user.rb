class DoctorOrUser < ApplicationRecord
	include AASM
	aasm column: :state do
		state :pending, :initial => true
		state :dealed
		state :not

		event :pass do
			transitions from: :pending, to: :dealed
			after do
				self.save
			end
		end

		event :not_pass do
			transitions from: :pending, to: :not
			after do
				self.save
			end
		end
	end


	def get_state
		if state == "pending"
			"待处理"
		elsif state == "dealed"
			"申请成功"
		else
			"申请失败"
		end
	end
end
