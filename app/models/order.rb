class Order < ApplicationRecord
  belongs_to :wechat_user
  belongs_to :address
  has_many :line_items, -> { where in_cart: false }, dependent: :destroy

  validates :quantity, numericality: { only_integer: true,  greater_than_or_equal_to: 1 }
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :wechat_user, :address, presence: true

  STATUS_TEXT = { pending: '待付款', wait_send: '待发货', wait_confirm: '待收货', cancel: '取消' }.freeze

  include AASM
  aasm column: :status do
    # 待付款，初始状态
    state :pending, initial: true
    # 待发货
    state :wait_send
    # 待收货确认
    state :wait_confirm
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
  end

  def number
    100000000 + self.id
  end
  # https://ruby-china.org/topics/26138
  # 只有当微信支付时使用到，订单一旦确认(confirm)，即进行获取
  # {remote_ip: request.ip}
  def set_prepay_id(options={})
    return true if Rails.env.development?
    return true if is_prepay_id_valid?
    # 重新更新支付流水号
    self.pay_serial_number = "#{number}-#{Time.current.to_i}"
    unifiedorder = {
      body: "#{SITE_NAME}-#{number}",
      out_trade_no: pay_serial_number,
      total_fee: (total_price * 100).to_i, # 需要转换为分
      spbill_create_ip: options[:remote_ip] || '127.0.0.1',
      notify_url: wx_notify_url,
      trade_type: "JSAPI",
      nonce_str: SecureRandom.hex,
      openid: user.openid
     }
     Rails.logger.debug("unifiedorder_params: #{unifiedorder}")
     res = WxPay::Service.invoke_unifiedorder(unifiedorder)
     if res.success?
      self.prepay_id = res["prepay_id"]
      self.pre_pay_id_expired_at = Time.current + 2.hours
      Rails.logger.debug("set prepay_id: #{self.prepay_id}")
      self.save(validate: false)
     else
      Rails.logger.debug("set prepay_id fail: #{res}")
      false
     end
  end

  # {remote_ip: request.ip}
  def get_prepay_id(options={})
    set_prepay_id(options) if !is_prepay_id_valid?
    prepay_id
  end

  def wx_notify_url
    "#{Rails.application.secrets.host_url}pay_notify/weixin_notify"
  end

  # 总价
  def total_price
    self.item_total.to_f - self.promo_total.to_f
  end

  # 判断是否有效
  def is_prepay_id_valid?
    prepay_id.present? && Time.current.to_i <= pre_pay_id_expired_at.to_i
  end
end
