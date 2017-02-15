class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :authentication_keys => [:telphone]
  has_one :member_record
  has_one :wechat_user
  has_many :orders
  has_one :cart
  has_many :examine_records
  has_many :addresses

  validates :invitation_card, uniqueness: true
  validates :telphone, uniqueness: true, presence: true, length: {is: 11}
  validates :identity_card, uniqueness: true, presence: true, length: { is: 18 }

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
end
