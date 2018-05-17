class DistributionInstockBusiness < InstockBusiness
  number_prefix "BHRK"
  include AASM
  aasm(:distribute_status) do
    state :pendding, :initial => true
    state :approved
    state :rejected
    event :review do
      transitions :from => :pendding, :to => :approved
      after do
        add_parallel_shop_stock self
        parallel_shop_sub_out_count self
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
