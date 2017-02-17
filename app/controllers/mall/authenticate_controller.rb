class Mall::AuthenticateController < Mall::BaseController
  def phone
    if bind_phone?
      redirect_to session[:return_to] || '/'
    end
    @no_fotter = true
  end

  def bind_phone
    if sms_code_validate(params[:code], params[:mobile])
      user = User.where(identity_card: params[:identity_card]).or(User.where(telphone: params[:mobile])).first
      if user.present?
        if user.binding_wechat_user?
          flash[:notice] = '此手机号或身份证号被某个微信号绑定过，需要先解绑'
          redirect_back fallback_location: mall_root_path
          return
        else
          current_user.update_user user
          current_user.update_mobile(params[:mobile])
        end
      else
        if !params[:invitation_user].nil?
          @invitation_user = User.find_by(invitation_card: params[:invitation_user])
          if !@invitation_user.nil?
            user = User.new(identity_card: params[:identity_card], password: params[:password], telphone: params[:mobile], name: params[:name],invitation_user: @invitation_user)
            if user.save
              current_user.update_user user
              current_user.update_mobile(params[:mobile])
            else
              flash[:notice] = '保存用户失败'
              redirect_back fallback_location: mall_root_path
              return
            end
          else
            user = User.new(identity_card: params[:identity_card], password: params[:password], telphone: params[:mobile], name: params[:name])
            if user.save
              current_user.update_user user
              current_user.update_mobile(params[:mobile])
            else
              flash[:notice] = '保存用户失败'
              redirect_back fallback_location: mall_root_path
              return
            end
          end
        end
      end
      redirect_to session[:return_to]
    else
      flash[:notice] = '验证码无效或过期, 请重新发送验证码'
      redirect_back fallback_location: mall_root_path
    end
  end
end
