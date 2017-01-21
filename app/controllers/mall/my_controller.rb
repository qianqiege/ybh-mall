class Mall::MyController < Mall::BaseController
  include BindPhone
  before_action :check_bind_phone, only: [:home]

  def home
    @pending_order_count = current_user.orders.pending.count
    @wait_send_order_count = current_user.orders.wait_send.count
    @wait_confirm_order_count = current_user.orders.wait_confirm.count
    @all_order_count = current_user.orders.count
  end

  def unbinding_wechat_user
    @wechat_user = WechatUser.find(params[:id])
    @wechat_user.update_attribute(:user_id, nil)
  end
end
