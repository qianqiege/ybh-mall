class AllocateApplicationBusiness < ApplicationBusiness
  number_prefix "DBSQ"

  validates :warehouse_id, numericality: { only_integer: true, message: "你选的仓库类型错误"}

  include AASM
  aasm column: :allocate_status do
    state :applying, :initial => true
    state :approved
    state :rejected
    event :review do
      transitions :from => :applying, :to => :approved
      after do
        create_allocate_outstock_business
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
  def create_allocate_outstock_business
    allocate = AllocateOutstockBusiness.create(
        business_number: AllocateOutstockBusiness.generator_number({:action => "new"}),
        up_id: self.id
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
