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
      identity_card_user = User.find_by(identity_card: params[:identity_card])
      if identity_card_user.present?
        current_user.update_user identity_card_user
      else
        user = User.new(identity_card: params[:identity_card], password: params[:password], telphone: params[:mobile], name: params[:name])
        if user.save
          current_user.update_user user
        else
          flash[:notice] = '保存用户失败'
          redirect_back fallback_location: mall_root_path
          return
        end
      end
      redirect_to session[:return_to]
    else
      flash[:notice] = '验证码无效或过期, 请重新发送验证码'
      redirect_back fallback_location: mall_root_path
    end
  end
end
