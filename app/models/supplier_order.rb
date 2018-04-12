class SupplierOrder < ApplicationRecord
  include AASM
  has_many :supplier_order_items
  belongs_to :supplier
  accepts_nested_attributes_for :supplier_order_items, allow_destroy: true

  before_create :updat_order_total
  before_update :updat_order_total

  scope :approved, -> {where(purchase_status: "approved")}
  scope :rejected, -> {where(purchase_status: "rejected")}
  scope :rejected, -> {where(purchase_status: "applying")}


  aasm column: :purchase_status do
    state :applying, :initial => true
    state :approved
    state :rejected

    event :review do
      transitions :from => :applying, :to => :approved
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
    self.supplier_order_items.each do |su|
      total = total + su.order_count*su.prices
    end
    self.amounts_payable = total*discount-preferential
  end
end
