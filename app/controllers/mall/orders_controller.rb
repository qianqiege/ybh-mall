class Mall::OrdersController < Mall::BaseController
  include BindPhone
  before_action :check_bind_phone, only: [:confirm]
  include HasAddress
  before_action :check_has_address, only: [:confirm]

  def create
  end

  def confirm
    @line_items = LineItem.where(id: session[:line_item_ids])
    @all_line_item_count =  @line_items.sum { |line_item| line_item.quantity }
    @total_price = @line_items.sum { |line_item| line_item.total_price }
    @recommend_address = current_user.addresses.find_by(id: params[:address_id]) || current_user.recommend_address
  end
end
