class InventoryProfit < Inventory
	number_prefix "PYCK"
	include AASM
  aasm column: :inventory_status do
    state :applying, :initial => true
    state :approved
    state :rejected
    event :review do
      transitions :from => :applying, :to => :approved
      after do
        # 加库存
        add_stock self
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