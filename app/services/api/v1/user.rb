class API::V1::User < API

  namespace :user, desc: '用户' do

    desc '用户'
    params do
      requires :user_id, type: Integer
    end

    get 'user_info' do
      # user信息 用户信息
      user_info = User.find(params[:user_id])
    end

    get 'wechat_user_info' do
      # 微信用户信息
      wechat_user = WechatUser.find_by(user_id: params[:user_id])
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
    end

    get 'code' do
      # 二维码
    end

    get 'health_record' do
      # 健康档案
    end

    get 'health_data' do
      # 动态数据
    end

  end

end
