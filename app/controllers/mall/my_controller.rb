class Mall::MyController < Mall::BaseController
  include BindPhone
  before_action :check_bind_phone, only: [:home]

  def home
    @pending_order_count = current_user.orders.pending.count
    @wait_send_order_count = current_user.orders.wait_send.count
    @wait_confirm_order_count = current_user.orders.wait_confirm.count
    @all_order_count = current_user.orders.count
  end
end
