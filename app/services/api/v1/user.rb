class API::V1::User < API

  namespace :user, desc: '用户相关' do

    desc '用户信息',detail: <<-NOTES.strip_heredoc
      > 请求成功返回信息

      ```json
      {
        "id": 2,
        "telphone": "138****7270",
        "identity_card": "210282*********8111",
        "id_number": "210282********8111",
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
        "error_message": "未找到该用户",
        "error_code": 401
      }
      ```
    NOTES
    params do
      requires :user_id, type: Integer
    end
    get 'user_info' do
      user_info = User.find(params[:user_id])
      present user_info,with: ::Entities::User
    end

    desc '微信用户信息',detail: <<-NOTES.strip_heredoc
      > 请求成功返回信息

      ```json
      {
        "id": 2,
        "nickname": "久伴",
        "headimgurl": "http://wx.qlogo.cn/mmhead/FB4omYLIWgia4SpzpD5ib4ydazhpqSD7GBzuBKwOmdkcc/0"
      }
      ```
      > 登陆失败返回信息

      ```json
      {
        "error_message": "未找到该微信用户",
        "error_code": 401
      }
      ```
    NOTES
    params do
      requires :user_id, type: Integer
    end
    get 'wechat_user_info' do
      wechat_user = WechatUser.find_by(user_id: params[:user_id])
      present wechat_user,with: ::Entities::WechatUser
    end

    desc '用户身份信息',detail: <<-NOTES.strip_heredoc
      > 请求成功返回信息

      ```json
      {
        "id": 2,
        "nickname": "久伴",
        "headimgurl": "http://wx.qlogo.cn/mmhead/FB4omYLIWgia4SpzpD5ib4ydazhpqSD7GBzuBKwOmdkcc/0"
      }
      ```
      > 登陆失败返回信息

      ```json
      {
        "error_message": "未找到该微信用户",
        "error_code": 401
      }
      ```
    NOTES
    params do
      requires :user_id, type: Integer
    end
    get 'user_info_review' do
      user_info_reviews = UserInfoReview.find_by(user_id: params[:user_id])
    end

    desc '更改或申请用户身份信息'
    params do
      requires :user_id, type: Integer
    end
    get 'edit_user_info_review' do
    end

    desc '新建用户'
    params do
    end
    post 'create_user' do
    end

    desc '方案'
    params do
      requires :user_id, type: Integer
    end
    get 'scheme' do
      scheme = HealthProgram.where(user_id: params[:user_id])
      present scheme,with: ::Entities::HealthProgram
    end

    desc '健康档案'
    params do
      requires :user_id, type: Integer
    end
    get 'health_record' do
      user = User.find(params[:user_id])
      mall = Sdk::Mall.new
      health_record = mall.record(user.id_number)
    end

    desc 'tds数字中医'
    params do
      requires :user_id, type: Integer
    end
    get 'tds' do
      idcard = User.find(params[:user_id])
      mall = Sdk::Mall.new
      tds_record = mall.tds_report(@idcard.identity_card)
    end

    desc '动态数据'
    params do
      requires :user_id, type: Integer
      requires :data_number, type: Integer
    end
    get 'health_data' do
      # 1 血压 # 2 血糖 # 3 血脂 # 4 体重 # 5 体温
      case params[:data_number]
      when 1
        @show = BloodPressure.where(user_id: params[:user_id])
      when 2
        @show = BloodGlucose.where(user_id: params[:user_id])
      when 3
        @show = BloodFat.where(user_id: params[:user_id])
      when 4
        @show = Weight.where(user_id: params[:user_id])
      when 5
        @show = Temperature.where(user_id: params[:user_id])
      end
    end

  end

end
