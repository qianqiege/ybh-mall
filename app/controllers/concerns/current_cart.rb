module CurrentCart
  extend ActiveSupport::Concern

  private

  def set_cart
    unless current_cart
      current_user.create_cart
    end
  end
end
