class User::InfoController < Wechat::BaseController
  def home
    @wechat_user = WechatUser.find(current_user)
  end

  def helath_record
    @idcard = User.find(current_user.user_id)
    mall = Sdk::Mall.new
    @record = mall.record(@idcard.identity_card)
  end

  def wechat_info
    @wechat_info = WechatUser.find(current_user)
  end

  def member_info
    @member = MemberRecord.where(user_id: current_user.user_id).take
  end

  def tds_record
    @idcard = User.find(current_user.user_id)
    mall = Sdk::Mall.new
    @tds_record = mall.tds_report(@idcard.identity_card)
  end
end
