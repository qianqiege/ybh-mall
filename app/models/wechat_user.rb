class WechatUser < ApplicationRecord
  has_one :cart
  has_many :addresses
  has_many :orders
  belongs_to :user
  has_many :line_items, through: :orders

  serialize :access_token_info, JSON
  serialize :auth_hash, Hash

  validates :open_id, presence: true, uniqueness: true

  delegate :locking_y, to: :user, allow_nil: true
  delegate :available_y, to: :user, allow_nil: true
  
  alias_attribute :name, :nickname

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

  def update_user(user)
    self.update_attribute(:user, user)
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
end
