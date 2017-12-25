class ParallelShop < ApplicationRecord
    has_many :purchase_orders
    has_many :stock_outs
    has_many :day_deals
    has_many :month_deal
    has_many :stock
    has_many :users
    belongs_to :plan


    include AASM
	aasm column: :status do
		# 初始化状态
		state :waiting, :initial => true

		#  已审核
		state :dealed

		# 未通过审核
		state :not

		event :pass do
			transitions from: :waiting, to: :dealed
			after do
				self.save
			end
		end

		event :not_pass do
			transitions from: :waiting, to: :not
			after do
				self.save
			end
		end
	end

	def get_status
		if status == "waiting"
			"待处理"
		elsif status == "dealed"
			"审核通过"
		else
			"未通过审核"
		end
	end

	def display_detail
	   "#{ChinaCity.get(province)} #{ChinaCity.get(city)} #{ChinaCity.get(street)} #{detail}"
	end


end
