class SmsCodesController < ApplicationController
  def show
    if sms_code.blank? or ( Time.now - sms_created_at ) > 1.minutes
      code = generate_code
      if Rails.env.production?
        # 发送短信代码
      else
        logger.info "sms code send: #{code} to mobile: #{params[:mobile]}"
      end
      session[:sms_code] = code
      session[:sms_created_at] = Time.now
      session[:mobile] = params[:mobile]
    else
      logger.info "手机验证码已经发过了，而且还没过期"
      logger.info "sms code has delivered at #{sms_created_at}"
    end
    render_success
  end

  private

  def sms_code
    session[:sms_code]
  end

  def sms_created_at
    if session[:sms_created_at]
      DateTime.parse(session[:sms_created_at])
    end
  end

  def generate_code
    rand(100000..999999).to_i.to_s
  end
end
