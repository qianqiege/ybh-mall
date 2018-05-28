# coding: utf-8
class API::V1::Users < Grape::API
  namespace :users, desc: '用户相关' do
    desc "通过手机号申请验证码，用于完成新用户的验证或者修改手机号码。",
         success: {code: 201, message: "验证码已发送"},
         detail: "这里分三种情况:
        1. 当新用户注册时，会自动根据手机号码创建用户
        2. 当是老用户修改手机或者小程序绑定时，必须传update_phone和access_token，并把手机号码存至待修改手机号码中
        3. 当是重置密码时，自动获取改手机号码用户
      "
    params do
      requires :telphone, type: String, desc: "合法的手机号码", documentation: {example: '13800138000'}
      optional :update_phone, type: Boolean, desc: "绑定/修改手机号码"
      optional :check_phone, type: Boolean, desc: '是否检查手机号码'
    end
    post :verify_code, failure: [
        {code: 403, message: '手机号码已存在，不能修改/绑定'}
    ] do
      telphone, verify_code = params[:telphone], rand.to_s[2..5]

      # 表示已传 access_token 用于记录手机号码修改
      if current_user && params[:update_phone]
        if User.find_by(telphone: params[:update_phone]).present?
          response_error "手机号码已存在，不能修改/绑定", 403
        end

        ChinaSMS.send_verify_msg(params[:update_phone], {code: verify_code})
        current_user.update_attributes! verify_code: verify_code,
                                        verify_code_expired_at: Time.now + 3.minutes,
                                        updating_phone: params[:telphone]
      else
        user = if params[:check_phone]
                 User.create! telphone: telphone
               else
                 User.find_or_create_by! telphone: telphone
               end

        ChinaSMS.send_verify_msg(user.telphone, {code: verify_code})
        user.update_attributes! verify_code: verify_code,
                                verify_code_expired_at: Time.now + 3.minutes

      end
      short_message "验证码已发送"
    end

    desc '手机验证码验证',
         success: { code: 201, message: '当前用户' }
    params do
      requires :telphone, type: String, desc: "合法的手机号码", documentation: {example: '13800138000'}
      requires :verify_code, type: String, desc: "验证码，支持沙盒验证码： 123456", documentation: {example: '75448929'}
    end

    post :verify, failure: [
        { code: 401, message: '手机号或验证码错误'}
    ] do
      if user = User.verify({ telphone: params[:telphone] }, params[:verify_code])
        authenticate user
        present user, with: ::Entities::UserAuth
      else
        response_error "手机号或验证码错误", 401
      end
    end
  end
end
