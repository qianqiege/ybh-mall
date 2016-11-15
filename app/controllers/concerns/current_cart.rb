module CurrentCart
  extend ActiveSupport::Concern

  private

  def set_cart
    @cart = Cart.find_by!(id: session[:cart_id], wechat_user_id: current_user.id)
  rescue ActiveRecord::RecordNotFound
    @cart = current_user.create_cart
    session[:cart_id] = @cart.id
  end
end
