class User::InfoController < Wechat::BaseController
  def home
    @vip_record = VipRecord.find(params[:format])
    @wechat_user = WechatUser.find(current_user)
  end

  def helath_record
    mall = Sdk::Mall.new
    @record = mall.record(100000000000000013)
  end

  def wechat_info
    @wechat_info = WechatUser.find(current_user)
  end
end
