class User::InfoController < Wechat::BaseController
  def home
    @wechat_user = WechatUser.find(current_user)
  end

  def helath_record
    @idcard = User.find(current_user)
    mall = Sdk::Mall.new
    @record = mall.record(@idcard.identity_card)
  end

  def wechat_info
    @wechat_info = WechatUser.find(current_user)
  end
end
