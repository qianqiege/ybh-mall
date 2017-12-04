class API::V1::Code < API

  namespace :code, desc: '二维码' do

    desc '二维码'
    params do
      requires :user_id, type: Integer
      requires :code_id, type: Integer
    end

    get 'invitation_code' do
      # 注册邀请码
      user = User.find(params[:user_id])
    end

    get 'health_code' do
      # 健康检测码
    end

    get 'activity_code' do
      # 活动推广码
    end

    post 'create_activity_code' do
      # 申请活动二维码
    end

    post 'update_activity_code' do
      # 更新活动二维码 用于管理员审批二维码
    end

    get 'all_activity_code' do
      # 活动二维码审核功能 查出所有二维码
    end

  end

end
