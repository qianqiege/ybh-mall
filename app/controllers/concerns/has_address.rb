module HasAddress
  extend ActiveSupport::Concern

  private

  def check_has_address
    unless session[:line_item_ids]
      session[:line_item_ids] = params[:line_item_ids].reject(&:blank?)
    end
    if current_user.addresses.empty?
      redirect_to mall_addresses_path
    end
  end
end
