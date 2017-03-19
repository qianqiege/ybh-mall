class User::BindingController < Wechat::BaseController
  def new
    @no_fotter = true
    @invitation_user = params[:invitation_id] || ""
  end

  def bind_phone
    if sms_code_validate(params[:code], params[:mobile])
      current_user.update_mobile(params[:mobile])
      # 绑定有折扣的会员vip
      @invitation_card = rand(1000000000..9999999999)
      if !params[:invitation_id].nil?
        @invitation_user = User.find_by(invitation_card: params[:invitation_id])
        @user = User.new(name: params[:name],telphone: params[:mobile],password: params[:password],identity_card: params[:identity_card],invitation_card: @invitation_card)

        if(@invitation_user.present?)
          @user.invitation_id = invitation_user.id
        end

        if(params[:is_doctor])
          @user.type = "Doctor"
        else
          @user.type = "Patient"
        end

        if @user.save && @wechat = WechatUser.find(current_user.id).update(user_id: @user.id)
          flash[:notice] = '恭喜您，注册成功'
          redirect_to root_path
          return
        else
          flash[:notice] = '对不起，注册失败'
          redirect_back fallback_location: user_binding_path
        end
      end
    else
      flash[:notice] = '验证码无效或过期, 请重新发送验证码'
      redirect_back fallback_location: user_binding_path
    end
  end
end
