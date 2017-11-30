class API::V1::Wallet < API
  namespace :wallet, desc: '钱包' do

    desc '钱包'
    params do
      requires :user_id, type: Integer
    end

    get 'user_wallet' do
      # 用户钱包
      wallet = Integral.find_by(user_id: params[:user_id])
      present wallet,with: ::Entities::Integral
    end

    get 'user_wallet_integral' do
      # 用户积分记录
      record = PresentedRecord.where(user_id: params[:user_id])
      present record,with: ::Entities::PresentedRecord
    end

    get 'user_wallet_cash' do
      # 用户余额记录
      record = CashRecord.where(user_id: params[:user_id])
      present record,with: ::Entities::CashRecord
    end

    get 'integral_exchange' do
      # 积分提现
    end

    get 'integral_give' do
      # 积分赠送
    end

  end

end
