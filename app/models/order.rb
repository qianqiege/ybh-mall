class Order < ApplicationRecord
  has_paper_trail
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

        # 付款成功后 执行下列方法

        # # 收入易积分
        add_ycoin
        # # 消费易积分
        remove_ycoin
        # # 收入代金券
        add_cash
        # # 消费代金券
        remove_cash
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

  # 收入易积分
  def add_ycoin
    # 1. 添加每天自动赠送规则
    # 2. 赠送第一天数据和第一次记录
    # 3. 如果有邀请人，赠送邀请人易积分
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

        # 判定条件，首次赠送 和 第一天赠送数量 大于0 执行创建方法
          if rule.coin_type.once > 0 && rule.coin_type.everyday > 0
            presented_records.create(user_id: user_id, number: rule.coin_type.once, reason: "首次赠送,订单id:#{id}",is_effective:1,type:"Available", wight: 4)
            presented_records.create(user_id: user_id, number: rule.coin_type.everyday, reason: "第一天赠送,订单id:#{id}",is_effective:1,type:"Available", wight: 5)
          end

          # 推荐好友消费赠送 直推奖励
          invitation = User.find(user_id).invitation_id
          # 判定条件，规则中赠送推荐人比例不为空，金额不为0，活动是 YBJ 执行创建方法
          if(rule.percent.present? && invitation.present? && self.price != 0 )
            # 赠送比例 乘 金额
            present_count = rule.percent * price
            presented_records.create(user_id: invitation, number: present_count, reason: "推荐好友消费,订单id:#{id}",is_effective:1,type:"Available", wight: 3)
          end

          # 推荐好友 员工推荐奖励
          # 判定 当前订单用户是否有邀请人 订单金额是否大于0 订单活动是否是 YBJ
          if invitation.present? && self.price != 0
            user_invitation = User.find(invitation).invitation_id
            # 如果 邀请人ID不为空继续循环
            while user_invitation.present?
              user_invitation = User.find(user_invitation).invitation_id
              # 如果邀请人ID为空 或者 邀请人的身份是 staff 停止循环
              if user_invitation.present? || User.find(user_invitation).status == "Staff"
                break
              end
            end
            # 判定是否有钱包账户 如果没有创建新的钱包账户
            if Integral.find_by(user_id: user_invitation).nil?
              Integral.create(user_id: user_invitation)
            end
            # 判定邀请人是否是员工 是员工的情况下 执行员工邀请奖励
            if user_invitation.present?
              invitation_status = User.find(user_invitation).status
              if invitation_status == "Staff"
                presented_records.create(user_id: user_invitation, number: self.price * rule.percent, reason: "会员链接奖励" , is_effective: 1 , type: "Available", wight: 2)
              end
            end

          end

          # 用户购买产品 返还用户易积分 购买产品返还的积分 为锁定积分 十五天后可用
          if rule.percentage.present? && self.price != 0
            presented_records.create(user_id: self.user_id, number: self.price * rule.percentage, reason: "购买产品返还积分",is_effective:1, type:"Locking", wight: 1)
          end

        end
      end
    end
  end

  # 支出易积分
  def remove_ycoin
    order_integral = self.integral
    balance_number = 0
    if order_integral > 0
      # 查询当前用户所有积分记录
      record = PresentedRecord.where(user_id: self.user_id).order(wight: :desc)
        record.each do |record|
          if !record.balance.nil? && record.balance > 0
            while order_integral > 0
              if record.balance >= order_integral
                presented_records.create(user_id: self.user_id, number: "-#{order_integral}", reason: "抵扣现金", is_effective:0, type: record.type ,record_id: record.id,wight: record.wight)
                record.update(balance: record.balance - order_integral)
                order_integral = 0
                break
              elsif record.balance <= order_integral
                order_integral = order_integral - record.balance
                presented_records.create(user_id: self.user_id, number: "-#{record.balance}", reason: "消费积分", is_effective:0, type: record.type ,record_id: record.id,wight: record.wight)
                record.balance = 0
                if record.save
                  break
                end
              end
            end
          end

          wallet = Integral.find_by(user_id: record.user_id)
          case record.wight
          when 1
            if wallet.update(available: wallet.available - self.integral, not_exchange: wallet.not_exchange - self.integral, appreciation: wallet.appreciation - self.integral)
              if order_integral <= 0
                break
              end
            end
          else
            if wallet.update(available: wallet.available - self.integral, exchange: wallet.exchange - self.integral, not_appreciation: wallet.not_appreciation - self.integral)
              if order_integral <= 0
                break
              end
            end
          end

      end
    end
  end

  # 收入代金券
  def add_cash
    # 查询当前用户的钱包账户
    integral = Integral.find_by(user_id: self.user_id)
    # 查询当前订单中的产品是否为可编辑产品
    is_custom = Product.find(self.line_items[0].product_id)

    # 如果 是自定义价格产品 非消费产品 便认定为充值 购买代金券
    if is_custom.is_custom_price == true && is_custom.is_consumption == false
      CashRecord.create(user_id: self.user_id, number: self.price, reason: "充值", is_effective:1)
    end
  end

  # 支出代金券
  def remove_cash
    # 查询当前用户的钱包账户
    integral = Integral.find_by(user_id: self.user_id)

    # 查询当前订单中的产品是否为可编辑产品
    is_custom = Product.find(self.line_items[0].product_id)

    # 如果 是自定义价格产品 是消费产品 便认定为消费代金券 判定账户中的代金券大于订单金额
    if is_custom.is_custom_price == true && is_custom.is_consumption == true && integral.not_cash >= self.price
      CashRecord.create(user_id: self.user_id, number: "-#{self.price}", reason: "消费", is_effective:0)
      # integral.update(not_cash: integral.not_cash - self.price)

    # 如果 不是自定义价格产品 是消费产品 便认定为消费代金券 判定账户中的代金券大于订单金额
    elsif self.cash > 0 && is_custom.is_custom_price == false && is_custom.is_consumption == true
      CashRecord.create(user_id: self.user_id, number: "-#{self.cash}", reason: "消费", is_effective:0)
      # integral.update(not_cash: integral.not_cash - self.not_cash)
    end
  end

end
