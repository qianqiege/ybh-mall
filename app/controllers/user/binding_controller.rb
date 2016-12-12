class User::BindingController < Wechat::BaseController
  def new
  end

  def bind_phone
    if sms_code_validate(params[:code], params[:mobile])
      current_user.update_mobile(params[:mobile])
      # 绑定有折扣的会员vip
      redirect_to session[:return_to]
      @user = User.new(telphone: params[:mobile],password: params[:password])
      @current_user = current_user.id
      if @user.save
        if @wechat = WechatUser.where('id LIKE ?',"%#{@current_user}%").update_all(user_id: @user.id)
          flash[:notice] = '绑定成功'
        else
          flash[:notice] = '绑定失败'
        end
      else
        flash[:notice] = '对不起 创建账户失败'
      end

    else
      flash[:notice] = '验证码无效或过期, 请重新发送验证码'
      redirect_back fallback_location: wechat_root_path

    end
  end

end
