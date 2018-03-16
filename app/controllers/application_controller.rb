class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_paper_trail_whodunnit

  def render_success(msg = nil, data = {})
    render :json => {
      success: true,
      message: msg.to_s
    }.merge(data)
  end

  helper_method :sms_code_validate
  def sms_code_validate(code, mobile)
    return false if session[:sms_code].blank? || !(session[:mobile] == mobile)
    sms_created_at = DateTime.parse(session[:sms_created_at])
    # 验证码10分钟内有效
    if Time.now - sms_created_at > 10.minutes
      session[:sms_code] = nil
      session[:sms_created_at] = nil
      session[:mobile] = nil
      return false
    end
    if session[:sms_code] == code
      return true
    end
  end

  def access_denied(exception)
    redirect_to '/admin/login', :alert => exception.message
  end

  def user_for_paper_trail
    admin_user_signed_in? ? current_admin_user.try(:email) : '系统自动创建'
  end

  def get_city_code_by name, parent_id = ''
    data = parent_id.present? ? ChinaCity.list(parent_id) : ChinaCity.list
    return_code = ''
    data.each do |value|
      if(value[0]) == name
        return_code = value[1]
        break
      end
    end
    return_code
  end

  # ApiAuth.authentic?(signed_request, secrect_key)

  def current_ability
    @current_ability ||= AdminAbility.new(current_admin_user)
  end
end
