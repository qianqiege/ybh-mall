class PurchaseInstockBusiness < InstockBusiness
  number_prefix "CGSQ"
  include AASM
  aasm column: :purchase_status do
    state :pendding, :initial => true
    state :approved
    state :rejected
    event :review do
      transitions :from => :pendding, :to => :approved
      after do
        add_stock self
      end

    end

    event :reject do
      transitions :from => :pendding, :to => :rejected
    end

    event :reapply do
      transitions :from => :rejected, :to => :applying
    end
  end

end
