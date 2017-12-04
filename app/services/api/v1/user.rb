class API::V1::User < API

  namespace :user, desc: '用户' do

    desc '用户'
    params do
      requires :user_id, type: Integer
      requires :code_id, type: Integer
      requires :data_number, type: Integer
    end

    get 'user_info' do
      # user信息 用户信息
      user_info = User.find(params[:user_id])
      present user_info,with: ::Entities::User
    end

    get 'wechat_user_info' do
      # 微信用户信息
      wechat_user = WechatUser.find_by(user_id: params[:user_id])
      present wechat_user,with: ::Entities::WechatUser
    end

    get 'user_info_review' do
      # 用户身份信息 查询
      user_info_reviews = UserInfoReview.find_by(user_id: params[:user_id])
    end

    get 'edit_user_info_review' do
      # 更改或申请用户身份信息
    end

    post 'create_user' do
      # 新建用户
    end

    post 'login' do
      # 登录
    end

    get 'scheme' do
      # 方案
      scheme = HealthProgram.where(user_id: params[:user_id])
      present scheme,with: ::Entities::HealthProgram
    end

    get 'health_record' do
      # 健康档案
      user = User.find(params[:user_id])
      mall = Sdk::Mall.new
      health_record = mall.record(user.id_number)
    end

    get 'tds' do
      # tds数字中医
    end

    get 'health_data' do
      # 动态数据
      # 1 血压
      # 2 血糖
      # 3 血脂
      # 4 体重
      # 5 体温
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
