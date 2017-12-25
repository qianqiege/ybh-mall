class Plan < ApplicationRecord
    belongs_to :user
    has_many :parallel_shops

    # serialize :partner_ids, Array


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
				self.active = true
				self.save
			end
		end
	end



	def fast_pay
	   @fast_pay ||= Sdk::FastPay.new(self)
	end



	def generate_number
	    begin
	      salt = rand(99999..999999)
	      self.number = "#{Time.current.to_s(:number)}#{salt}"
	    end while self.class.exists?(number: number)
	end



end
