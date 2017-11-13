class Order < ApplicationRecord
  has_paper_trail
  attr_accessor :account, :password
  include PresentedConcern

  belongs_to :wechat_user
  belongs_to :user
  belongs_to :address
  belongs_to :lottery_prize
  belongs_to :activity
  has_many :line_items, -> { where in_cart: false }, dependent: :destroy
  has_many :return_requests
  has_many :hight_ticket

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

  STATUS_TEXT = { pending: '待付款', wait_send: '待发货', wait_confirm: '待收货', cancel: '已取消', received: '已收货' ,return_change: '退货/款'}.freeze
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
        if is_donation != true
          # # 收入易积分
          add_ycoin
          # # 消费易积分
          remove_ycoin
          # # 收入代金券
          add_cash
          # # 消费代金券
          remove_cash
          # # 一盏明灯
          update_hight
          # # 优惠券
          update_lottery
        end

        # # 模板消息
        send_template_msg
        # # 更新YBZ会员邀请数
        update_ybz_vip_number

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

    event :return_change do
      transitions from: [:pending,:wait_send,:received,:wait_confirm], to: :return_change
      after do
        update_return
      end
    end

    event :pay_cancel do
      transitions from: :wait_send, to: :cancel
      after do
        if self.cash > 0 && self.price <= 0
          CashRecord.create(user_id: self.user_id, number: self.cash, reason: "订单退换积分，订单ID#{self.id}", is_effective:1)
        elsif self.integral > 0 && self.price <= 0
          presented_records.create(user_id: self.user_id, number: self.integral, reason: "订单退换积分，订单ID#{self.id}",is_effective:1, type:"Available", wight: 10)
        end
      end
    end

    event :send_product do
      transitions from: :wait_send, to: :wait_confirm
      after do
        send_product_templdate_msg
      end
    end

    event :receive do
      transitions from: :wait_confirm, to: :received
    end

    event :pay_donation do
      after do
        pay_donation
      end
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

  def pay_donation
    add_ycoin
    add_cash
    self.is_donation = false
    self.save
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

  def update_return
    # 退货 退款 计算 重置积分
    @record = PresentedRecord.where(presentable_id: self.id)

    i = 1
    while i <= @record.length
      @record.each do |record|
        @wallte = Integral.find_by(user_id: record.user_id)
        if record.type != "Available"
          @wallte.locking = @wallte.locking - record.balance
        elsif
          @wallte.available = @wallte.available - record.balance
        end
        if @wallte.save
          record.balance = 0
          record.is_effective = 0
          record.reason = "退款/退货被重置"
          if record.save
            i = i + 1
          end
        end

      end
    end

  end

  def remote_express_info
    Express.query self.express_number
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
    if !self.activity_id.nil? && self.activity_id != 12
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

          if rule.donation.present?
            DonationRecord.create(user_id: user_id,integral: rule.donation * self.price ,reason: "YBZ会员募捐（积分）",order_number: self.number)
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
            while !user_invitation.nil?
              user = User.find(user_invitation)
              if user.invitation_id.present?
                user_invitation = user.invitation_id
                # 如果邀请人ID为空 或者 邀请人的身份是 staff 停止循环
                if user_invitation.present? || User.find(user_invitation).status == "Staff" || User.find(user_invitation).status == "staff"
                  break
                end
              elsif !user.invitation_id.present? && User.find(user_invitation).status == "Staff" || User.find(user_invitation).status == "staff"
                user_invitation = user.id
                break
              elsif user_invitation.nil? || user.invitation_id.nil?
                break
              end
            end

            if User.find(invitation).status == "Staff" || User.find(invitation).status == "staff"
              user_invitation = invitation
            end
            # 判定是否有钱包账户 如果没有创建新的钱包账户
            if Integral.find_by(user_id: user_invitation).nil?
              Integral.create(user_id: user_invitation)
            end
            # 判定邀请人是否是员工 是员工的情况下 执行员工邀请奖励
            if user_invitation.present?
              invitation_status = User.find(user_invitation).status
              if invitation_status == "Staff" || invitation_status == "staff"
                presented_records.create(user_id: user_invitation, number: self.price * rule.staff, reason: "员工政策奖励" , is_effective: 1 , type: "Available", wight: 2)
              end
            elsif invitation.present? && invitation_status == "Staff" || invitation_status == "staff"
              presented_records.create(user_id: invitation, number: self.price * rule.staff, reason: "员工政策奖励" , is_effective: 1 , type: "Available", wight: 2)
            end
          end

          if User.find(self.user_id).status == "staff" || User.find(self.user_id).status == "Staff"
            presented_records.create(user_id: self.user_id, number: self.price * rule.staff, reason: "员工政策奖励" , is_effective: 1 , type: "Available", wight: 2)
          end
          # 用户购买产品 返还用户易积分 购买产品返还的积分 为锁定积分 十五天后可用
          if rule.percentage.present? && self.price != 0
            @integral_price = self.price
            products = Product.find(self.line_items.pluck(:product_id))
            products.each do |product|
              if !product.activity_id.nil?
                @integral_price = @integral_price - product.now_product_price
              end
            end
            presented_records.create(user_id: self.user_id, number: @integral_price * rule.percentage, reason: "购买产品返还积分",is_effective:1, type:"Locking", wight: 1)
          end

        end
      end
    end
  end

  # 支出易积分
  def remove_ycoin
    order_integral = self.integral
    if order_integral > 0
      # 查询当前用户所有积分记录
      record = PresentedRecord.where(user_id: self.user_id).order(wight: :desc)
      record.each do |record|
        if !record.balance.nil? && record.balance > 0
          while order_integral > 0
            if record.balance >= order_integral
              presented_records.create(user_id: self.user_id, number: "-#{order_integral}", reason: "消费积分", is_effective:0, type: record.type ,record_id: record.id,wight: record.wight)
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
    # if is_custom.is_custom_price == true && is_custom.is_consumption == false
    #
    #   case packang
    #   when "A方案"
    #     self.price = self.price - 55260
    #   when "B方案"
    #     self.price = self.price - 16880
    #   when "C方案"
    #     self.price = self.price - 18754
    #   when "D方案"
    #     self.price = self.price - 26880
    #   when "A方案"
    #     if self.price == 12000
    #       self.price = self.price - 11940
    #     end
    #   end
    #   CashRecord.create(user_id: self.user_id, number: self.price, reason: "充值", is_effective:1)
    # end
  end

  # 支出代金券
  def remove_cash
    if self.cash > 0
      # 查询当前用户的钱包账户
      integral = Integral.find_by(user_id: self.user_id)

      # 查询当前订单中的产品是否为可编辑产品
      is_custom = Product.find(self.line_items[0].product_id)

      # 如果 是自定义价格产品 是消费产品 便认定为消费代金券 判定账户中的代金券大于订单金额
      if is_custom.is_custom_price == true && is_custom.is_consumption == true && integral.not_cash >= self.price
        CashRecord.create(user_id: self.user_id, number: "-#{self.cash}", reason: "消费", is_effective:0)
        # integral.update(not_cash: integral.not_cash - self.price)

      # 如果 不是自定义价格产品 是消费产品 便认定为消费代金券 判定账户中的代金券大于订单金额
      elsif self.cash > 0 && is_custom.is_custom_price == false && is_custom.is_consumption == true
        CashRecord.create(user_id: self.user_id, number: "-#{self.cash}", reason: "消费", is_effective:0)
        # integral.update(not_cash: integral.not_cash - self.not_cash)
      end
    end
  end

  def update_ybz_vip_number
    if self.activity_id == 8 && self.is_ybz == 1
      user = User.find_by(id: self.user.invitation_id)
      if !user.nil?
        user.ybz_number = user.ybz_number + 1
        if user.save
          self.is_ybz = 0
          self.save
        end
      end
    else
      self.is_ybz = 0
      self.save
    end
  end

  def update_hight
    hight = HightTicket.where(order_id: self.id)
    hight.each do |hight|
      hight.to_start
      hight.save
    end
  end

  def update_lottery
    if !self.lottery_prize_id.nil?
      lottery = UserPrize.find(self.lottery_prize_id)
      lottery.to_use
      lottery.save
    end
  end

  def send_template_msg
    data = {
      first: {
        value: "您的订单支付成功",
        color: "#173177"
      },
      keyword1: {
        value: number,
        color: "#173177"
      },
      keyword2: {
        value: price.to_f.to_s + "元",
        color:"#173177"
      },
      keyword3: {
        value: DateTime.parse(created_at.to_s).strftime('%Y年%m月%d日 %H:%M'),
        color:"#173177"
      },
      remark: {
        value: get_line_items_info.join(""),
        color:"#173177"
      }
    }

    Settings.weixin.template_id =  "lcZBK5Y_wzwz7FZbJ-PPfCV_ieroP3ucCAVGsdSvx9E"
    # Settings.weixin.template_id = "W3VOrnqPgxby4BKiSHFO8Eez79pjfGf_5HCXd98N-ok"

    url = Settings.weixin.host + "/mall/orders/" + self.id.to_s

    open_id = User.find(self.user_id).wechat_user.open_id

    $wechat_client.send_template_msg(open_id, Settings.weixin.template_id, url, "#FD878E", data)

  end

  def send_product_templdate_msg
    data = {
      first: {
        value: "你好，你的订单已发货",
        color: "#173177"
      },
      keyword1: {
        value: number,
        color:"#173177"
      },
      keyword2:{
        value: User.find(user_id).telphone,
        color:"#173177"
      },
      remark:{
        value: "请在商城我的订单中查询物流信息",
        color:"#173177"
      }
    }

    Settings.weixin.template_id =  "nA4JMQFs5HBRiIMwxInqj5TE94VXnHu7-I3o-VtjrBU"
    # Settings.weixin.template_id = "tYUWJ1saT3ZEH4YtV8JnUhqb94_okcU16b1gg-0RvaY"
    url = Settings.weixin.host + "/mall/orders/" + self.id.to_s

    open_id = User.find(self.user_id).wechat_user.open_id

    $wechat_client.send_template_msg(open_id, Settings.weixin.template_id, url, "#FD878E", data)
  end



  def get_line_items_info
    message = []
    self.line_items.each do |line|
      quantity = line.quantity.to_s + " 份 "
      product_name = Product.find(line.product_id).name + ";   "
      message.push  quantity
      message.push  product_name
    end
    message
  end

end
