class UserPrize < ApplicationRecord
  belongs_to :user
  belongs_to :lottery_prize
  has_many :orders

  include AASM
  aasm column: :state do
    # 初始状态
    state :pending, initial: true

    # 已过期状态
    state :not

    # 已使用状态
    state :use

    event :to_not do
      transitions from: :pending, to: :not
    end

    event :to_use do
      transitions from: :pending, to: :use
    end

  end
end
