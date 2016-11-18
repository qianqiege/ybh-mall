module HasAddress
  extend ActiveSupport::Concern

  private

  def check_has_address
    if current_user.addresses.empty?
      redirect_to mall_addresses_path
    end
  end
end
