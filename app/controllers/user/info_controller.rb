class User::InfoController < Wechat::BaseController
  def home
    @vip_record = VipRecord.find(params[:format])
    @wechat_user = WechatUser.find(current_user)
  end

  def helath_record
    @idcard = VipRecord.find(params[:format])
    mall = Sdk::Mall.new
    @record = mall.record(@idcard.identity_card)
  end

  def wechat_info
    @wechat_info = WechatUser.find(current_user)
  end
end
