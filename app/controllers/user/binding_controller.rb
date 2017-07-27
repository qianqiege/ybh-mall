class User::BindingController < Wechat::BaseController
  def new
    if current_user.user.present?
      flash[:notice] = '您已注册，无须重复注册'
      redirect_to root_path
    end
    @no_fotter = true
    @tp = params[:format]
    # @recommender = User.find_by(invitation_card: params[:invitation_id])

    # 如果当前用户没有推荐人，自动添加推荐人
    # if current_user.recommender.nil? && @recommender.present?
    #   current_user.update_attributes(recommender: @recommender)
    # end
    @invitation_user = params[:invitation_id] || ""
  end

  def bind_phone
    if sms_code_validate(params[:code], params[:mobile])
      current_user.update_mobile(params[:mobile])
      # 绑定有折扣的会员vip

      # 生成随机邀请码
      @invitation_card = rand(1000000000..9999999999)

      # 生成系统身份码
      size = 18
      charset = %w{ 2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z}
      identity_card = (0...size).map{ charset.to_a[rand(charset.size)] }.join

      @invitation_user = User.find_by(invitation_card: params[:invitation_id])

      @user = User.new(name: params[:name],telphone: params[:mobile],password: params[:password],identity_card: identity_card,invitation_card: @invitation_card,status: "User",ybz_number: 0)

      # # 如果原来已经有推荐人了，注册直接绑定推荐人
      # if current_user.recommender.present?
      #   @user.invitation_id = current_user.recommender.id
      # end

      if @invitation_user.present?
        @user.invitation_id = @invitation_user.id
      end

      if(params[:is_doctor])
        @user.type = "Doctor"
      else
        @user.type = "Patient"
      end

      if @user.save && @wechat = WechatUser.find(current_user.id).update(user_id: @user.id)
        flash[:notice] = '恭喜您，注册成功'
        redirect_to root_path
        @user.send_template_msg
        @user.send_message
        return
      else
        flash[:notice] = '对不起，注册失败'
        redirect_back fallback_location: user_binding_path
      end

    else
      flash[:notice] = '验证码无效或过期, 请重新发送验证码'
      redirect_back fallback_location: user_binding_path
    end
  end
end
