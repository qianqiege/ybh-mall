class User < ApplicationRecord
  has_one :member_record
  has_one :wechat_user
  has_many :orders
  has_many :examine_records

  validates :telphone, uniqueness: true, presence: true, length: {is: 11}
  validates :password, presence: true, length: { in: 6..20 }
  validates :identity_card, uniqueness: true, presence: true, length: { is: 18 }


  def name
    identity_card
    # 使telephone在active_admin中用作name来显示
  end

  def discount
    MembershipCard.where(id: User.where(id: current_user.user_id)).take.discount
    #获取当前会员用户的会员卡折扣，没有为10折
  end

  def idcard
    User.find(current_user.user_id).take.identity_card
  end
end
