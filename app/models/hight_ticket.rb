class HightTicket < ApplicationRecord
  belongs_to :user
  belongs_to :order

  after_create :ticket_code

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
      after do
        self.save
      end
    end

    event :to_use do
      transitions from: :start, to: :use
      after do
        self.save
      end
    end

    event :to_not do
      transitions from: :start, to: :not
    end

    event :to_app do
      transitions from: :start, to: :app
    end
  end

  def ticket_code
    size = 8
    charset = %w{ 2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z}
    code = (0...size).map{ charset.to_a[rand(charset.size)] }.join

    self.ticket_number = code
    self.save
  end

end
