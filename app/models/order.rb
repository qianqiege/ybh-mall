class Order < ApplicationRecord
  attr_accessor :account, :password

  belongs_to :wechat_user
  belongs_to :user
  belongs_to :address
  belongs_to :activity
  has_many :line_items, -> { where in_cart: false }, dependent: :destroy
  has_many :return_requests

  has_many :scoin_account_order_relations, dependent: :destroy
  has_many :scoin_accounts, through: :scoin_account_order_relations, dependent: :destroy

  default_scope { order(id: :desc) }

  validates :quantity, numericality: { only_integer: true,  greater_than_or_equal_to: 1 }
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  # 暂时把address和wechat_user的验证去掉
  validates :user, presence: true
  validates_uniqueness_of :number

  before_validation :set_user
  before_create :generate_number
  after_create :set_used_address, :create_scoin_account

  STATUS_TEXT = { pending: '待付款', wait_send: '待发货', wait_confirm: '待收货', cancel: '已取消', received: '已收货' }.freeze
  PAY_TYPE_TEXT = { '0' => '线上付款', '1' => '线下付款' }.freeze

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

  # 订单应该绑定user_id，而不是wechat_user_id
  # 暂时先保存，后续需去掉wechat_user_id
  def set_user
    self.user_id = wechat_user.user_id if wechat_user.present?
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

  def pay_type_state
    PAY_TYPE_TEXT[self.pay_tp.to_s]
  end

  def name
    number
  end

  private

  def set_used_address
    self.user.used_address_id = self.address_id
    self.user.save validate: false
    if self.wechat_user.present?
      self.wechat_user.used_address_id = self.address_id
      self.wechat_user.save validate: false
    end
  end

  def create_scoin_account
    begin
      s_account = ScoinAccount.find_by(account: account)
      if s_account.nil?
        s_account = ScoinAccount.create!(account: account, password: "QWER1234!", user_id: user_id, state: "未开户")
      end
      ScoinAccountOrderRelation.create!(order: self, scoin_account: s_account)
    rescue ActiveRecord::ActiveRecordError => e
      errors.add(:user_id, e.message)
      raise ActiveRecord::Rollback
    end
  end

end
