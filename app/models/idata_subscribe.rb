class IdataSubscribe < ApplicationRecord
	belongs_to :user

	before_create :generate_number


	include AASM
	aasm column: :status do
		#付款失败
		state :failing, initial: true

		#付款成功
		state :success

		event :pay do
			transitions from: :failing, to: :success

			after do
				#更新用户订阅列表状态
				UserIdataSubscribe.find_by(user_id: user_id).update(status: "success")

				#用户付款成功后，为用户订阅相应服务
				list = UserIdataSubscribe.find_by(user_id: user_id).list
				list.each do |service_id|
					idata_active_service(service_id)
				end
			end
		end
	end

	def fast_pay
	   @fast_pay ||= Sdk::FastPay.new(self)
	end


	#数动力用户订阅
	def idata_active_service(service_id)
	    result = WechatUser.find_by(user_id: user_id).idata.active_service(service_id)


	    Rails.logger.info "@"*20
	    Rails.logger.info "用户订阅"
	    Rails.logger.info result

	    
	    if (result.first['code'] != '0000')
	      raise Exception.new(result)
	    end
	end



	def generate_number
	    begin
	      salt = rand(99999..999999)
	      self.number = "#{Time.current.to_s(:number)}#{salt}"
	    end while self.class.exists?(number: number)
	end
end

