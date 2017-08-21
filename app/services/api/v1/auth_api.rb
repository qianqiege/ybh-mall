class API::V1::AuthApi < Grape::API
  namespace :auth, desc: '登录授权' do

    params do
      requires :account, type: String
      requires :password, type: String
    end
    post "login" do
      number = params[:account].length
      case number
      when 11
        user = User.find_by(telphone: params[:account])
        if user && user.valid_password?(params[:password])
        end
      when 18
        user = User.find_by(identity_card: params[:account])
        if user && user.valid_password?(params[:password])
        end
      else
        user = User.find_by(email: params[:account])
        if user && user.valid_password?(params[:password])
        end
      end

    end

  end
end
