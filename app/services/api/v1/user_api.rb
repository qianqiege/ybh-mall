class API::V1::UserApi < API
  namespace :users, desc: '用户相关' do

    desc '注册'
    params do
      requires :phone, type: String
      requires :password, type: String
      requires :name, type: String
    end

    post 'create_user' do
      user = User.new(telphone: params[:phone],password: params[:password],name: params[:name])

      if !params[:email].nil?
        user.email = params[:email]
      end
      if !params[:identity_card].nil?
        user.identity_card = params[:identity_card]
      end

      if user.save
        present user
      else
        {error: user.errors.full_messages}
      end
    end

  end
end
