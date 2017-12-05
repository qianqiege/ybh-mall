class API::V1::Auth < API

  namespace :auth, desc: '用户相关' do
    desc '登录',detail: <<-NOTES.strip_heredoc
      > 请求成功返回信息

      ```json
      {
        "id": 2,
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
