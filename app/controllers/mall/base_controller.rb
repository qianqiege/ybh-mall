# coding: utf-8
module Mall
  class BaseController < Wechat::BaseController
    layout "mall"

    helper_method :current_cart_count
    before_action :set_current_cart_count

    protected

    def bind_phone?
      current_user.mobile.present?
    end

    private

    def current_cart_count=(count)
      @cart_count = count
    end

    def current_cart_count
      @cart_count ||= current_user.cart_count
    end

    def set_current_cart_count
      return unless bind_phone?
      current_cart_count
    end
  end
end
