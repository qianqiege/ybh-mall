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
				current_user_idata_subscribe_list = UserIdataSubscribeList.last.list.split(",")

				Rails.logger.info "@"*40
				Rails.logger.info "after pay"
				Rails.logger.info UserIdataSubscribeList.last.inspect
				
				current_list = []

				if current_user_idata_subscribe_list			
				
					current_user_idata_subscribe_list.each do |service_id|
						hash = {
							service_id: service_id,
							end_time: Time.now+1.year
						}
						current_list.push(hash)
					end

				end

				Rails.logger.info "#"*40
				Rails.logger.info "after_pay"
				Rails.logger.info current_list

				#付款成功后，创建创建或更新用户订阅列表
				if UserIdataSubscribe.find_by(user_id: user_id).blank?
			      UserIdataSubscribe.create(list: current_list, user_id: user_id, status: "success")
			    else
			      last_list = UserIdataSubscribe.find_by(user_id: user_id).list
			      
			      Rails.logger.info "@:"*20
			      Rails.logger.info last_list

			      #清除原来单个元素为字符串的数组
			      last_list.each do |f|
			      	if f.class == String
			      		last_list.clear
			      	end
			      end

			      # for n in last_list do
			      # 	puts n
			      # 	if n.class == String
			      # 		puts "jfiods: #{n}"
			      # 		last_list.delete(n)
			      # 	end
			      # end

			      Rails.logger.info "#"*20
			      Rails.logger.info last_list

			      #更新已经重复订阅的服务
			      if !last_list.blank?
				      last_list.each do |f|
				      	current_list.each do |e|
				      		if f[:service_id] == e[:service_id]
				      			f[:end_time] = e[:end_time]
				      		end
				      	end
				      end
			      end

			      #合并所有的服务
			      final_list = last_list | current_list

			      UserIdataSubscribe.find_by(user_id: user_id).update(list: final_list, status: "success")

			    end

				#用户付款成功后，为用户订阅相应服务
				list = UserIdataSubscribe.find_by(user_id: user_id).list.pluck(:service_id)
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
def gg
	a = [1,2,3,4,5,6]
	b = [3,4,5,6,7,8,9,10]
	a.each do |f|
		b.each do |e|
			if f == e
				b.delete(e)
			end
		end
	end
	puts a
	puts b
end