class User::BindingController < Wechat::BaseController
  def new
    if current_user.user.present?
      flash[:notice] = '您已注册，无须重复注册'
      redirect_to root_path
    end
    @no_fotter = true
    @tp = params[:format]
    @recommender = User.find_by(invitation_card: params[:invitation_id])
    if !params["entrustment"].nil?
      @entrustment = params["entrustment"]
    end
    # 如果当前用户没有推荐人，自动添加推荐人
    if current_user.recommender.nil? && @recommender.present?
      current_user.recommender = @recommender.id
      current_user.save
    end
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
      identity_card = (0...size).map {charset.to_a[rand(charset.size)]}.join

      @invitation_user = User.find_by(invitation_card: params[:invitation_id])

      @user = User.new(name: params[:name], telphone: params[:mobile], password: params[:password], identity_card: identity_card, invitation_card: @invitation_card, status: "User", ybz_number: 0)

      # # 如果原来已经有推荐人了，注册直接绑定推荐人
      # if current_user.recommender.present?
      #   @user.invitation_id = current_user.recommender.id
      # end


      # <ActionController::Parameters {"utf8"=>"✓", "authenticity_token"=>"taVYJ/8M+MipUwooFvYSrfmrmnXepGkWXGxLFXjwB9GOOu12QAYXLD1iBSgvQzLQgBnny3lKrpRRcOk0+s774g==",
      #   "invitation_id"=>"", "name"=>"zhoufabin", "password"=>"123456", "identity"=>"family_health_manager", "work_address"=>{"province"=>"340000", "city"=>"341600",
      #     "street"=>"341622"}, "resident_address"=>{"province"=>"320000", "city"=>"321100", "street"=>"321182"}, "mobile"=>"18888653566", "code"=>"173401",
      #     "agreeCheck"=>"on", "controller"=>"user/binding", "action"=>"bind_phone"} permitted: false>


      if params[:identity] != "user"
        if params[:sameaddress] == "on"
          @user_info_review = UserInfoReview.new(identity: params[:identity],
                                                 work_province: params[:work_address][:province],
                                                 work_city: params[:work_address][:city],
                                                 work_street: params[:work_address][:street],
                                                 resident_province: params[:work_address][:province],
                                                 resident_city: params[:work_address][:city],
                                                 resident_street: params[:work_address][:street]);
        else
          @user_info_review = UserInfoReview.new(identity: params[:identity],
                                                 work_province: params[:work_address][:province],
                                                 work_city: params[:work_address][:city],
                                                 work_street: params[:work_address][:street],
                                                 resident_province: params[:resident_address][:province],
                                                 resident_city: params[:resident_address][:city],
                                                 resident_street: params[:resident_address][:street]);
        end
      end

      if @invitation_user.present?
        @user.invitation_id = @invitation_user.id
        @user.staff_invitation_type = @invitation_user.status
      end

      if (params[:is_doctor])
        @user.type = "Doctor"
      else
        @user.type = "Patient"
      end
      if params["entrustment"] == "1"
        if @user.save && @wechat = WechatUser.find(current_user.id).update(user_id: @user.id)
          redirect_to 'wechat/show_consumer_entrustment', notice: '恭喜您，注册成功'

          return
        end
      end
      if @user_info_review.blank?
        if @user.save && @wechat = WechatUser.find(current_user.id).update(user_id: @user.id)
          flash[:notice] = '恭喜您，注册成功'

          # 若是从影子店扫营业员二维码，  则回到影子店页面
          if params[:waiter_id] != ""
            redirect_to wechat_parallel_shops_shopdata_path(money: params[:money], waiter_id: params[:waiter_id])
          else
            redirect_to root_path
          end


          @user.send_template_msg
          @user.send_message
          return
        else
          flash[:notice] = '对不起，注册失败'
          redirect_back fallback_location: user_binding_path
        end
      else
        if @user.save && @wechat = WechatUser.find(current_user.id).update(user_id: @user.id) && @user_info_review.save
          @user_info_review.update!(user_id: @user.id)
          flash[:notice] = '你的信息正在审核中'
          redirect_to root_path
        else
          flash[:notice] = '注册失败，请检查您的信息'
          redirect_back fallback_location: user_binding_path
        end
      end
    else
      flash[:notice] = '验证码无效或过期, 请重新发送验证码'
      redirect_back fallback_location: user_binding_path
    end
  end
end
