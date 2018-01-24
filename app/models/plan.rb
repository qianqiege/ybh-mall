class Plan < ApplicationRecord
    belongs_to :user
    has_many :parallel_shops
    before_save :change_number
    has_many :money_details
		has_many :partners, class_name: "Plan", foreign_key: "invite_plan_id"
		belongs_to :invite_plan, class_name: "Plan"

    def change_number
        self.code = Plan.generate_number
    end

    def self.generate_number
      loop do
        salt = rand(99999..999999)
        coding = "PL"+"#{Date.current.to_s(:number)}#{salt}"
        break coding unless self.exists?(number: coding)
      end
    end

    def name
        self.code
    end

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
