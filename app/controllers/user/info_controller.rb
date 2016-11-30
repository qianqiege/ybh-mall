class User::InfoController < Wechat::BaseController
  def show
    @vip_record = VipRecord.all
    @wechat_user = WechatUser.all
  end
end
