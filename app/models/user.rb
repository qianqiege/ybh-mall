class User < ApplicationRecord
  YTER_PROFILE = { 7 => "中心总裁", 6 => "总店长", 5 => "店长", 4 => "分店长", 3 => "柜长", 2 => "组长", 1 => "医通er", 0 => "未参与"}.freeze
  has_paper_trail
  belongs_to :parallel_shop
  has_many :plans
  has_many :money_details
  # 操作记录
  include PresentedConcern

  after_create :create_invitation
  after_create :create_present

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :authentication_keys => [:telphone]
  has_one :member_record
  has_one :wechat_user
  has_many :cash_record
  has_many :apply_codes
  has_many :hight_tickets
  has_many :user_prizes
  has_many :orders
  has_one :cart
  has_one :integral
  has_many :ecgs
  has_many :appraise
  has_many :examine_records
  has_many :exchange_records
  has_many :addresses
  has_many :unines
  has_many :regular_reports
  has_many :temperatures
  has_many :blood_glucoses
  has_many :blood_pressures
  has_many :weights
  has_many :heart_rates
  has_many :blood_fats
  has_many :identity_cards
  has_many :deposits
  has_many :idata_subscribes
  has_many :user_idata_subscribes
  has_many :ycoin_records, dependent: :destroy, as: :account
  has_many :donation_records
  has_many :celebrate_ratsimps
  has_one :user_info_review
  has_one :shop
  has_many :shop_orders

  # has_many :recommenders, :class_name => "WechatUser", :foreign_key => "recommender_id"

  belongs_to :organization
  belongs_to :invitation, class_name: 'User', foreign_key: 'invitation_id'

  validates :invitation_card, uniqueness: true
  validates :telphone, uniqueness: true, presence: true, length: {is: 11}
  validates :identity_card, uniqueness: true, presence: true, length: { is: 18 }

  def self.verify(params = {}, verify_code)
    user = find_by params
    return unless user

    return unless (verify_code == user.verify_code) &&
        user.verify_code_expired_at > Time.now

    user
  end

  def verified?
    verified_at.present?
  end

  def get_token
    token = Devise.friendly_token
    while User.where(authentication_token: token).first do
      token = Devise.friendly_token
    end
    token
  end

  def generate_authentication_token

    self.update_attribute :authentication_token, get_token
  end

  # 已经有真实姓名了，暂时去掉
  # def name
  #   identity_card
  #   # 使telephone在active_admin中用作name来显示
  # end

  # 验证此用户是否被微信账号绑定过
  def binding_wechat_user?
    WechatUser.find_by(user_id: self.id) ? true : false
  end

  def discount
    MembershipCard.where(id: User.where(id: current_user.user_id)).take.discount
    #获取当前会员用户的会员卡折扣，没有为10折
  end

  def idcard
    User.find(current_user.user_id).take.identity_card
  end

  def recommend_address
    if default_address = addresses.find_by(is_default: true)
      default_address
    elsif used_address = addresses.find_by(id: self.used_address_id)
      used_address
    else
      addresses.last
    end
  end

  def generate_access_token
    begin
      self.access_token = Devise.friendly_token
      self.expires_at = 2.days.from_now
    end while self.class.exists?(access_token: access_token)
  end

  def update_access_token
    generate_access_token
    p "@$"*40
    p generate_access_token
    save
  end

  def lockable?
    if locked_at.present?
      errors.add(:base, '用户已锁定')
      false
    else
      true
    end
  end

  def create_invitation
    # 在易积分记录表中插入一条积分收支记录，默认为有效记录，积分计入到锁定积分中
    Integral.create(user_id: self.id, locking: 0, available: 0, exchange: 0, cash: 0, not_exchange:0, not_cash: 0, appreciation: 0, not_appreciation: 0, count: 0)
  end

  def create_present
    if !self.invitation_id.nil?
      presented_records.create(user_id: self.invitation_id, number: 6, reason: "邀请好友赠送",is_effective:1,type:"Available",wight: 1)
      lottery_user = User.find(self.invitation_id)
      lottery_user.lottery_number = lottery_user.lottery_number.to_i + 1
      lottery_user.save
    end

    if !self.invitation_id.nil?
      presented_records.create(user_id: self.id, number: 30, reason: "（活动）被邀请奖励",is_effective:1,type:"Notexchange",wight: 2)
    else
      presented_records.create(user_id: self.id, number: 10, reason: "（活动）注册奖励",is_effective:1,type:"Notexchange",wight: 2)
    end
  end

  def send_template_msg
    data = {
      first: {
        value:"欢迎您成为御易健会员",
        color:"#173177"
      },
      keyword1:{
        value: identity_card,
        color:"#173177"
      },
      keyword2:{
        value: name,
        color:"#173177"
      },
      keyword3:{
        value: telphone,
        color:"#173177"
      },
      keyword4:{
        value: "请您进入医通平行店设置",
        color:"#173177"
      },
      keyword5:{
        value: DateTime.parse(created_at.to_s).strftime('%Y年%m月%d日 %H:%M'),
        color:"#173177"
      },
      remark:{
        value: "感谢您的加入。",
        color:"#173177"
      }
    }
    Settings.weixin.template_id =  "EOh9eEjDXeArKy0odjDdVW6-GI8GnWIqWfg92eWEyFs"
    # Settings.weixin.template_id =  "eTwEAFZ2rdA4iFpna3phVwk786_gf7_gQP-z3TbEaG4"
    url = Settings.weixin.host
    open_id = self.wechat_user.open_id

    $wechat_client.send_template_msg(open_id, Settings.weixin.template_id, url, "#FD878E", data)
  end

  # 发送短信
  def send_message
    tpl_params = { number1: self.name }

    if Rails.env.production?
      ChinaSMS.use :yunpian, password: Settings.sms_password
      ChinaSMS.to telphone, tpl_params, tpl_id: Settings.register_tpl_id
    else
      logger.info "sms code send: #{tpl_params} to mobile: #{telphone}"
    end

  end

  def update_status
    if self.status.nil? || self.status.present?
      self.status = "User"
      self.save
    end
  end

  def display_name
    "#{self.name}-#{self.telphone}"
  end

  def invitation_user_name
    if !invitation.nil?
      invitation.name
    end
  end
  def yter_profile_name
    YTER_PROFILE[self.yter_profile]
  end

  private
  def clear_verified_msg
    # 校验后清楚验证码
    if changes[:verified_at].present?
      self.verify_code = nil
      self.verify_code_expired_at = nil
    end
    # 设置密码后清楚已校验信息
    if changes[:encrypted_password].present?
      self.verified_at = nil
      self.authentication_token = get_token
    end
  end
end
