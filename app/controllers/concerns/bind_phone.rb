module BindPhone
  extend ActiveSupport::Concern

  private

  def check_bind_phone
    unless bind_phone?
      store_location
      if request.xhr?
        render json: { location: mall_authenticate_phone_path }
      else
        redirect_to mall_authenticate_phone_path
      end
    end
  end
end
