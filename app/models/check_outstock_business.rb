class CheckOutstockBusiness < OutstockBusiness
  number_prefix "PDCK"
  include AASM
  aasm(:inventory_status) do
    state :applying, :initial => true
    state :approved
    state :rejected
    event :review do
      transitions :from => :applying, :to => :approved
      after do
        check_sub_stock self
      end
    end

    event :reject do
      transitions :from => :applying, :to => :rejected
    end

    event :reapply do
      transitions :from => :rejected, :to => :applying
    end
  end
end
