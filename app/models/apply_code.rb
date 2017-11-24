class ApplyCode < ApplicationRecord
  after_create :update_state
  belongs_to :user

  def update_state
    self.state = "pending"
    self.save
  end

  include AASM
  aasm column: :state do
    # 初始状态
    state :pending, initial: true
    # 可用
    state :available
    # 作废
    state :void

    event :update_available do
      transitions from: :pending, to: :available
      after do
        self.save
      end
    end

    event :update_pending_to_void do
      transitions from: :pending, to: :void
      after do
        self.save
      end
    end

    event :update_available_to_void do
      transitions from: :available, to: :void
      after do
        self.save
      end
    end

  end

end
