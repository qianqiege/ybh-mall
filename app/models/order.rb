class Order < ApplicationRecord
  attr_accessor :account, :password
  include PresentedConcern

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
  # validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  # 暂时把address和wechat_user的验证去掉
  validates :user, presence: true
  validates_uniqueness_of :number

  before_validation :set_user
  before_create :generate_number, :copy_price_to_initial_price
  after_create :set_used_address, :create_scoin_account

  STATUS_TEXT = { pending: '待付款', wait_send: '待发货', wait_confirm: '待收货', cancel: '已取消', received: '已收货' }.freeze
  PAY_TYPE_TEXT = { '0' => '线上付款', '1' => '线下付款' }.freeze
  PAYMENT_TEXT = { PAYMENT_TYPE_WECHAT: '微信支付', PAYMENT_TYPE_YJ: '银行卡支付' }.freeze

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
        # 购买赠送
        add_ycoin_records
        add_ycoin_invitation
        # staff_integral
        add_cash_record
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

  def copy_price_to_initial_price
    self.initial_price = price
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
    STATUS_TEXT[self.status.to_sym] if self.status
  end

  def pay_type_state
    PAY_TYPE_TEXT[self.pay_tp.to_s] if self.pay_tp
  end

  def payment_label
    PAYMENT_TEXT[self.payment.to_sym] if self.payment
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
    scoin_type_count = Activity.search(id_eq: activity_id, activity_rules_coin_type_type_eq: "ScoinType").result.count

    # 有赠送s货币才需要开通账号
    if activity_id.present? && scoin_type_count == 1 && !account.nil?
      begin
        s_account = ScoinAccount.find_by(account: account)
        if s_account.nil?
          s_account = ScoinAccount.create!(account: account, password: "QWER1234!", user_id: user_id, state: "未开户")
        end
        ScoinAccountOrderRelation.create!(order: self, scoin_account: s_account)
      rescue ActiveRecord::ActiveRecordError => e
        logger.info e.message
        errors.add(:user_id, e.message)
        raise ActiveRecord::Rollback
      end
    end
  end

  # 1. 添加每天自动赠送规则
  # 2. 赠送第一天数据和第一次记录
  # 3. 如果有邀请人，赠送邀请人易积分
  def add_ycoin_records
    if !self.activity_id.nil?
      rules = activity.activity_rules.match_rules(price)
      rules.map do |rule|
        if rule.coin_type.type == 'YcoinType'
          user.ycoin_records.create!(
            coin_type_id: rule.coin_type_id,
            start_at: 1.day.from_now,
            end_at: (rule.coin_type.days - 1).day.from_now
          )
          current_time = Time.current.strftime('%Y-%m-%d %H:%M:%S')

          # 在易积分记录表中插入一条积分收支记录，默认为有效记录，积分计入到锁定积分中
          if rule.coin_type.once > 0 && rule.coin_type.everyday > 0
            presented_records.create(user_id: user_id, number: rule.coin_type.once, reason: "首次赠送,订单id:#{id}",is_effective:1,type:"Available")
            presented_records.create(user_id: user_id, number: rule.coin_type.everyday, reason: "第一天赠送,订单id:#{id}",is_effective:1,type:"Available")
          end

          # 推荐好友消费赠送
          invitation = User.find(user_id).invitation_id
          if(rule.percent.present? && invitation.present? && self.price != 0)
            present_count = rule.percent * price
            presented_records.create(user_id: invitation, number: present_count, reason: "推荐好友消费,订单id:#{id}",is_effective:1,type:"Available")
          end
          if rule.percentage.present? && self.price != 0
            presented_records.create(user_id: self.user_id, number: self.price * rule.percentage, reason: "购买产品返还积分",is_effective:1,type:"Locking")
          end
        end
      end
    end
  end

  def add_ycoin_invitation
    if !self.integral.nil? && self.integral > 0

      count_integral = 0
      surplus_integral = 0
      p_record = PresentedRecord.where("user_id = ? AND is_effective = ? AND type = ?", self.user_id , 1 , "Available")

      while self.integral >= surplus_integral

        p_record.each do |record|
          # 收支记录中的 number 大于所用的数量
          if record.number >= self.integral
            count_integral = count_integral + record.number - self.integral
            if record.update(is_effective: 0)
              presented_records.create(user_id: self.user_id, number: "-#{self.integral}", reason: "消费" , is_effective: 0 , type: "Available", record_id: record.id)
              if record.number - self.integral > 0
                presented_records.create(user_id: self.user_id, number: record.number - self.integral , reason: "消费剩余" , is_effective: 1 , type: "Available", record_id: record.id)
              end
            end
            if surplus_integral == 0 || surplus_integral < 0
              break
            end
          # 收支记录中的 number 大于所用的数量
          else
            if surplus_integral != 0 && surplus_integral > 0
              surplus_integral = surplus_integral - record.number
            else
              surplus_integral = self.integral - record.number
            end
            if record.update(is_effective: 0)
              presented_records.create(user_id: self.user_id, number: "-#{record.number}", reason: "消费" , is_effective: 0 , type: "Available", record_id: record.id)
              if surplus_integral < 0
                presented_records.create(user_id: self.user_id, number: surplus_integral * -1, reason: "消费剩余" , is_effective: 0 , type: "Available", record_id: record.id)
              end
            end
            if surplus_integral == 0 || surplus_integral < 0
              break
            end
          end
        end
        if surplus_integral == 0 || surplus_integral < 0
          break
        end
      end

    end
  end

  def staff_integral
    invitation = User.find(user_id).invitation_id

    if invitation.present? && self.price != 0
      user_invitation = User.find(invitation).invitation_id
      # 如果 邀请人ID不为空继续循环
      while user_invitation.present?
        user_invitation = User.find(user_invitation).invitation_id
        # 如果邀请人ID为空 或者 邀请人的身份是 staff 停止循环
        if user_invitation.present? || User.find(user_invitation).status == "staff"
          break
        end
      end
    end

    if Integral.find_by(user_id: user_invitation).nil?
      Integral.create(user_id: user_invitation, locking: 0 ,available: 0, exchange: 0)
    end

    if User.find(user_invitation).status == "staff"
      presented_records.create(user_id: user_invitation, number: self.price * rule.percent, reason: "会员邀请消费赠送" , is_effective: 1 , type: "Available")
    end
  end

  def add_cash_record
    integral = Integral.find_by(user_id: self.user_id)
    is_custom = Product.find(self.line_items[0].product_id)
    if is_custom.is_custom_price == true && is_custom.is_consumption == false
      CashRecord.create(user_id: self.user_id, number: self.price, reason: "充值", is_effective:1)
      integral.update(cash: integral.cash + self.price)
    elsif is_custom.is_custom_price == true && is_custom.is_consumption == true && integral.cash >= self.price
        CashRecord.create(user_id: self.user_id, number: "-#{self.price}", reason: "消费", is_effective:1)
        integral.update(cash: integral.cash - self.price)
    elsif self.cash > 0 && is_custom.is_custom_price == false && is_custom.is_consumption == true
      CashRecord.create(user_id: self.user_id, number: "-#{self.cash}", reason: "消费", is_effective:1)
      integral.update(cash: integral.cash - self.cash)
    end
  end

  def remove_cash_integral
    integral = Integral.find_by(user_id: self.user_id)
    integral.update(available: integral.available - self.available, cash: integral.cash - self.cash)
  end

end
