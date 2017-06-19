class ExchangeRecord < ApplicationRecord
  belongs_to :user

  include AASM
  aasm column: :state do
     state :pending , :initial => true
     state :dealing
     state :dealed
     state :not

     event :pass do
       transitions from: :pending, to: :dealing
       after do
         self.save
       end
     end

     event :deal do
       transitions from: :dealing, to: :dealed
       after do
         self.save
       end
     end

     event :not do
       transitions from: :pending, to: :not
       after do
         self.save
         not_ycoin
       end
     end

   end

   def not_ycoin
     if self.state == "not"
       not_record = PresentedRecord.new(user_id: self.user_id,reason: "提现退换",number: self.number,is_effective: 1,type: "Available",balance: self.number,wight:2)
       if not_record.save
       end
     end
   end

end
