class PurchaseApplicationBusiness < ApplicationBusiness
  number_prefix "CGSQ"
  before_create :updat_order_total
  before_update :updat_order_total

  validates :supplier_id, presence: true
  validates :warehouse_id, numericality: { only_integer: true, message: "你选的仓库类型错误"}

  include AASM
  aasm column: :purchase_status do
    state :applying, :initial => true
    state :approved
    state :rejected
    event :review do
      transitions :from => :applying, :to => :approved
      after do
        purchaser = PurchaseInstockBusiness.create(
            business_number: PurchaseInstockBusiness.generator_number({:action => "new"}),
            up_id: self.id,
            warehouse_id: self.warehouse_id
        )
        self.spd_business_items.each do |item|
          SpdBusinessItem.create(
              spd_business_id: purchaser.id,
              product_id: item.product_id,
              count: item.count
          )
        end
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
  def updat_order_total
    total = 0
    self.spd_business_items.each do |item|
      total = total + item.count.to_f * item.price
    end
    self.amounts_payable = total * discount.to_f - preferential.to_f
  end
end
