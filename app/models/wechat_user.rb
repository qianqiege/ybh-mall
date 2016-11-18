class WechatUser < ApplicationRecord
  has_one :cart
  has_many :addresses

  serialize :access_token_info, JSON
  serialize :auth_hash, Hash

  validates :open_id, presence: true, uniqueness: true
  VALID_MOBILE_REGEX = /\A(13[0-9]|15[012356789]|17[0123456789]|18[0-9]|14[57])[0-9]{8}\z/
  validates :mobile, format: { with: VALID_MOBILE_REGEX, message: '格式不正确' }

  def set_userinfo user_basic_info
    self.subscribe = user_basic_info['subscribe'] if user_basic_info['subscribe'].present?
    self.nickname = user_basic_info['nickname'] if user_basic_info['nickname'].present?
    self.headimgurl = user_basic_info['headimgurl'] if user_basic_info['headimgurl'].present?
    self.auth_hash = user_basic_info if user_basic_info.present?
    true # always return true
  end

  def auth_data
    @auth_data ||= OpenStruct.new(auth_hash)
  end

  def is_wechat_authorized?
    access_token_info.present?
  end

  def cart_count
    if cart.present?
      cart.line_items.to_a.sum { |item| item.quantity }
    else
      0
    end
  end

  def update_mobile(mobile)
    self.update_attribute(:mobile, mobile)
  end
end
