class ParallelShop < ApplicationRecord
    include ImageConcern
    has_many :purchase_orders
    has_many :stock_outs
    has_many :day_deals
    has_many :month_deal
    has_many :sale_products
    has_many :stock
    has_many :users
    belongs_to :plan
    belongs_to :admin_user

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

	# 生成一个id，title的二维数组
	# ['lisbon', 1], ['Madrid', 2]...]
	def self.get_id_with_title
		arr = []
		ParallelShop.pluck(:id).each do |id|
			item = []
			title = ParallelShop.find(id).title
			p "@"*30
			p title
			p id
			item.push(title);
			item.push(id);
			p item
			arr.push(item)
			p arr
		end
		return arr
	end



end
