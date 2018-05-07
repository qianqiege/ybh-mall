class DistributionOutstockBusiness < OutstockBusiness
  number_prefix "BHCK"

  include AASM
  aasm column: :distribute_status do
    state :applying, :initial => true
    state :approved
    state :rejected
    event :review do
      transitions :from => :applying, :to => :approved
      after do
        create_distribute_instock_business
        sub_stock self
      end
    end

    event :reject do
      transitions :from => :applying, :to => :rejected
    end

    event :reapply do
      transitions :from => :rejected, :to => :applying
    end
  end
  private
  def create_distribute_instock_business
    distribute = DistributionInstockBusiness.create(
        up_id: self.id,
        business_number: DistributionInstockBusiness.generator_number({:action => "new"}),
        parallel_shop_id: self.up.parallel_shop_id,
        distribute_status: "pendding"
    )
    self.spd_business_items.each do |item|
      SpdBusinessItem.create(
          spd_business_id: distribute.id,
          product_id: item.product_id,
          count: item.count
      )
    end
  end
end
