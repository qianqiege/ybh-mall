class WechatUser < ApplicationRecord
  has_one :cart
  has_many :addresses
  has_many :orders
  belongs_to :user
  # 推荐人
  belongs_to :recommender, :class_name => "User", :foreign_key => "recommender_id"

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

  def update_wechat_info
    user_basic_info = $wechat_client.user(open_id).result
    self.set_userinfo(user_basic_info)
    self.save
  end

  def idata
    @idata ||= Sdk::Idata.new(self)
  end

  def send_template_msg 
        data = {
          first: { 
            value:"欢迎您成为御易健会员", 
            color:"#173177" 
          }, 
          keyword1:{ 
            value: User.find(self.user_id).identity_card, 
            color:"#173177" 
          }, 
          keyword2:{ 
            value: self.nickname.to_s, 
            color:"#173177" 
          }, 
          keyword3:{ 
            value: self.mobile.to_s, 
            color:"#173177" 
          }, 
          keyword4:{
            value: "请您进入御易健商城设置",
            color:"#173177" 
          },
          keyword5:{
            value: DateTime.parse(self.created_at.to_s).strftime('%Y年%m月%d日 %H:%M'),
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
          open_id = self.open_id

          $wechat_client.send_template_msg(open_id, Settings.weixin.template_id, url, "#FD878E", data)
  end


end
