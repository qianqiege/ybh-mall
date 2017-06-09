class ExchangeRecord < ApplicationRecord
  belongs_to :user

  include AASM
  aasm column: :state do
     state :pending , :initial => true
     state :dealing
     state :dealed

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
   end

end
