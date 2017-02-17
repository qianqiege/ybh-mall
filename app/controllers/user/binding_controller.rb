class User::BindingController < Wechat::BaseController
  def new
    @no_fotter = true
    @invitation_user = params[:invitation_user] || ""
  end

  def bind_phone

    if sms_code_validate(params[:code], params[:mobile])
      current_user.update_mobile(params[:mobile])
      # 绑定有折扣的会员vip
      @invitation_card = rand(1111111111..9999999999)
      if !params[:invitation_user].nil?
        @invitation_user = User.find_by(invitation_card: params[:invitation_user])
        if !@invitation_user.nil?
          @user = User.new(name: params[:name],telphone: params[:mobile],password: params[:password],identity_card: params[:identity_card],invitation_card: @invitation_card,invitation_user: @invitation_user.id)
          @current_user = current_user.id
          if @user.save && @wechat = WechatUser.where('id LIKE ?',"%#{@current_user}%").update_all(user_id: @user.id)
            redirect_to user_root_path
          else
            flash[:notice] = '绑定失败'
            redirect_back fallback_location: user_binding_path
          end
        else
          @user = User.new(name: params[:name],telphone: params[:mobile],password: params[:password],identity_card: params[:identity_card],invitation_card: @invitation_card)
          @current_user = current_user.id
          if @user.save && @wechat = WechatUser.where('id LIKE ?',"%#{@current_user}%").update_all(user_id: @user.id)
            redirect_to user_root_path
          else
            flash[:notice] = '绑定失败'
            redirect_back fallback_location: user_binding_path
          end
        end
      end
    else
      flash[:notice] = '验证码无效或过期, 请重新发送验证码'
      redirect_back fallback_location: user_binding_path
    end
  end
end
