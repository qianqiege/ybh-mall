class ApplyCode < ApplicationRecord
  before_create :update_state
  belongs_to :user

  def update_state
    self.state = "panding"
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

    event :update_void do
      transitions from: :pending, to: :void
      after do
        self.save
      end
    end

  end

end
