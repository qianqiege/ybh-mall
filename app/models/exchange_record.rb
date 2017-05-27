class ExchangeRecord < ApplicationRecord
  belongs_to :user

  include AASM
  aasm column: :state do
    state :false , :initial => true
    state :true

    event :u_state do
      transitions from: :false, to: :true
      after do
        self.save
      end
    end
  end
end
