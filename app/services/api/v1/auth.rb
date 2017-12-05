class API::V1::Auth < API

  namespace :auth, desc: '用户相关' do
    desc '登录',detail: <<-NOTES.strip_heredoc
      > 请求成功返回信息

      ```json
      {
        "id": 2,
        "access_token": "GsneygSQSzn_eSm5H5Qy",
        "expires_at": "2017-12-07 11:49:19 +0800",
        "telphone": "13823767270",
        "identity_card": "210************111",
        "id_number": "210************111",
        "name": "萧炎",
        "invitation_card": "98******98",
        "invitation_id": 1,
        "email": "email@ybyt.ccc",
        "type": "Patient",
        "status": "Staff",
        "lamp_number": 1,
        "is_partner": true,
        "family_health_manager": false,
        "family_doctor": false,
        "health_manager": false,
        "staff_type": "R&D"
      }
      ```
      > 登陆失败返回信息

      ```json
      {
        "error_message": "用户名或密码错误",
        "error_code": 401
      }
      ```

      > 编号辨识

      ```json
      {
        'account' = '身份证号码' 18位
        'account' = '手机号码' 11位
      }
      ```
    NOTES
    params do
      requires :account,type: String
      requires :password,type: String
    end
    post http_codes: [
      [201, '登陆成功'],
      [401, '用户名或密码错误']
    ] do

      if params[:account].length == 11
        @user = User.find_by(telphone: params[:account])
      elsif params[:account].length == 18
        @user = User.find_by(id_number: params[:account])
      end

      if @user && @user.valid_password?(params[:password])
        @user.update_access_token
        present(@user, with: ::Entities::User)
      else
        error!({ error_message: "用户名或密码错误", error_code: 4001 }, 401)
      end

    end
  end
end
