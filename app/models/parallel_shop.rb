class ParallelShop < ApplicationRecord
    has_many :purchase_orders
    has_many :stock_outs
    has_many :day_deals
    has_many :month_deal
    has_many :stock
    has_many :users
    belongs_to :user


    include AASM
	aasm column: :status do
		state :waiting, :initial => true
		state :dealed
		state :not

		event :pass do
			transitions from: :waiting, to: :dealed
			after do
				p "&"*200
				self.save
			end
		end

		event :not_pass do
			transitions from: :waiting, to: :not
			after do
				p "@"*200
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
