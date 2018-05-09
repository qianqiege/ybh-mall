class InventoryLoss < Inventory
	number_prefix "PKCK"
	include AASM
  aasm column: :inventory_status do
    state :applying, :initial => true
    state :approved
    state :rejected
    event :review do
      transitions :from => :applying, :to => :approved
      after do
        # 减库存
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
end