class User::HomeController < Wechat::BaseController
  def index
    @vip_record = VipRecord.all
    @wechat_user = WechatUser.all
  end
end
