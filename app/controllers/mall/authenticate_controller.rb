class Mall::AuthenticateController < Mall::BaseController
  def phone
    if bind_phone?
      redirect_to session[:return_to] || '/'
    end
    @no_fotter = true
  end

  def bind_phone
    if sms_code_validate(params[:code], params[:mobile])
      current_user.update_mobile(params[:mobile])
      # 绑定有折扣的会员vip
      redirect_to session[:return_to]
    else
      flash[:notice] = '验证码无效或过期, 请重新发送验证码'
      redirect_to :back
    end
  end
end
