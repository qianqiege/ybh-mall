class AllocateInstockBusiness < InstockBusiness
  number_prefix "DBRK"
  include AASM
  aasm column: :allocate_status do
    state :pendding, :initial => true
    state :approved
    state :rejected
    event :review do
      transitions :from => :pendding, :to => :approved
      after do
        add_stock self
        sub_out_count self
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
