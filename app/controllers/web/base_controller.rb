# coding: utf-8
module Web
  class BaseController < ApplicationController
  #   before_action :authenticate_user!

    layout "web"

  #   helper_method :current_cart, :current_cart_count
  #   before_action :set_current_cart_count

  #   private

  #   def current_cart=(cart)
  #     @current_cart = cart
  #   end

  #   def current_cart
  #     @current_cart ||= current_user.cart
  #   end

  #   def current_cart_count
  #     current_cart.try(:real_product_count).to_i
  #   end

  #   def set_current_cart_count
  #     current_cart_count
  #   end
  end
end
