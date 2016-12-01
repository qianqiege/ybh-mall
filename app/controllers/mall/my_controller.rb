class Mall::MyController < Mall::BaseController
  include BindPhone
  before_action :check_bind_phone, only: [:home]

  def home
    @pending_order_count = Order.pending.count
    @wait_send_order_count = Order.wait_send.count
    @all_order_count = Order.count
  end
end
