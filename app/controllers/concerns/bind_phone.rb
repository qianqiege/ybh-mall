module BindPhone
  extend ActiveSupport::Concern

  private

  def store_location
    session[:return_to] = request.url if request.get?
  end

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
