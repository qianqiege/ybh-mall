class Order < ApplicationRecord
  belongs_to :wechat_user
  belongs_to :address
  belongs_to :activity
  has_many :line_items, -> { where in_cart: false }, dependent: :destroy
  has_many :return_requests

  default_scope { order(id: :desc) }

  validates :quantity, numericality: { only_integer: true,  greater_than_or_equal_to: 1 }
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :wechat_user, :address, presence: true
  validates_uniqueness_of :number

  before_create :generate_number

  STATUS_TEXT = { pending: '待付款', wait_send: '待发货', wait_confirm: '待收货', cancel: '已取消', received: '已收货' }.freeze

  include AASM
  aasm column: :status do
    # 待付款，初始状态
    state :pending, initial: true
    # 待发货, 已支付状态
    state :wait_send
    # 待收货确认, 已发货状态
    state :wait_confirm
    # 已收货
    state :received
    # 退换货
    state :return_change
    # 取消
    state :cancel

    event :pay do
      transitions from: :pending, to: :wait_send
      after do
        line_items.each do |line_item|
          line_item.product.pay_reduce_shop_count(line_item.quantity)
        end
      end
    end

    event :make_cancel do
      transitions from: :pending, to: :cancel
      after do
        line_items.each do |line_item|
          line_item.product.back_shop_count(line_item.quantity)
        end
      end
    end

    event :send_product do
      transitions from: :wait_send, to: :wait_confirm
    end

    event :receive do
      transitions from: :wait_confirm, to: :received
    end
  end

  def generate_number
    begin
      salt = rand(99999..999999)
      self.number = "#{Time.current.to_s(:number)}#{salt}"
    end while self.class.exists?(number: number)
  end

  def trade_name
    line_items.map(&:product_name).join(',')
  end

  def fast_pay
    @fast_pay ||= Sdk::FastPay.new(self)
  end

  def human_state
    STATUS_TEXT[self.status.to_sym]
  end

  def name
    number
  end
end
