class AllocateOutstockBusiness < OutstockBusiness
  number_prefix "DBCK"
  include AASM
  aasm column: :allocate_status do
    state :applying, :initial => true
    state :approved
    state :rejected
    event :review do
      transitions :from => :applying, :to => :approved
      after do
        create_allocate_instock_business
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
  def create_allocate_instock_business
    allocate = AllocateInstockBusiness.create(
        up_id: self.id,
        business_number: AllocateInstockBusiness.generator_number({:action => "new"}),
        warehouse_id: self.up.warehouse.id,
        allocate_status: "pendding"
    )
    self.spd_business_items.each do |item|
      SpdBusinessItem.create(
          spd_business_id: allocate.id,
          product_id: item.product_id,
          count: item.count
      )
    end
  end
end
