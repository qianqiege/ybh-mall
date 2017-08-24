class HightTicket < ApplicationRecord
  belongs_to :user
  belongs_to :order

  include AASM
  aasm column: :state do
    # 未生效，初始状态
    state :panding, initial: true

    # 已生效
    state :start

    # 已使用
    state :use

    # 已失效
    state :not

    #已兑换
    state :app

    event :to_start do
      transitions from: :panding, to: :start
    end

    event :to_use do
      transitions from: :start, to: :use
    end

    event :to_not do
      transitions from: :start, to: :not
    end

    event :to_app do
      transitions from: :start, to: :app
    end
  end

end
