class User::BindingController < Wechat::BaseController
  def new
    @no_fotter = true
  end

  def bind_phone
    if sms_code_validate(params[:code], params[:mobile])
      current_user.update_mobile(params[:mobile])
      # 绑定有折扣的会员vip
      @user = User.new(name: params[:name],telphone: params[:mobile],password: params[:password],identity_card: params[:identity_card])
      @current_user = current_user.id
      if @user.save && @wechat = WechatUser.where('id LIKE ?',"%#{@current_user}%").update_all(user_id: @user.id)
        redirect_to user_root_path
      else
        flash[:notice] = '绑定失败'
        redirect_back fallback_location: user_binding_path
      end
    else
      flash[:notice] = '验证码无效或过期, 请重新发送验证码'
      redirect_back fallback_location: user_binding_path
    end
  end
end
