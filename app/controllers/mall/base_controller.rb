# coding: utf-8
module Mall
  class BaseController < Wechat::BaseController
    layout "mall"

    helper_method :current_cart, :current_cart_count
    before_action :set_current_cart_count

    protected

    def bind_phone?
      current_user.user.present?
    end

    private

    def current_cart=(cart)
      @current_cart = cart
    end

    def current_cart
      @current_cart ||= current_user.cart
    end

    def current_cart_count
      current_cart.try(:real_product_count).to_i
    end

    def set_current_cart_count
      return unless bind_phone?
      current_cart_count
    end

    def store_location
      session[:return_to] = request.url if request.get?
    end
  end
end
