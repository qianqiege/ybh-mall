class Mall::OrdersController < Mall::BaseController
  include BindPhone
  before_action :check_bind_phone, only: [:confirm]
  include HasAddress
  before_action :check_has_address, only: [:confirm]

  def create
  end

  def confirm
    line_item_ids = params[:line_item_ids].reject(&:blank?)
    session[:line_item_ids] = line_item_ids
    @line_items = LineItem.where(id: line_item_ids)
    @all_line_item_count =  @line_items.sum { |line_item| line_item.quantity }
    @total_price = @line_items.sum { |line_item| line_item.total_price }
  end
end
