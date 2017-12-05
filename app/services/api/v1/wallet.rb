class API::V1::Wallet < API
  namespace :wallet, desc: '钱包' do

    desc '钱包',detail: <<-NOTES.strip_heredoc
      > 请求成功返回信息

      ```json
      {
        "locking": "0.0",
        "available": "4948354.88",
        "not_exchange": "1300.0",
        "cash": "0.0",
        "not_cash": "100398.0"
      }
      ```
    NOTES
    params do
      requires :user_id, type: Integer
    end
    get 'user_wallet' do
      wallet = Integral.find_by(user_id: params[:user_id])
      present wallet,with: ::Entities::Integral
    end

    desc '用户积分记录',detail: <<-NOTES.strip_heredoc
      > 请求成功返回信息

      ```json
      {
        {
            "reason": "注册赠送",
            "number": "3.0",
            "is_effective": true,
            "balance": "0.0",
            "status": "系统创建",
            "desc": null,
            "type": "Available",
            "created_at": "2017-06-08T08:38:30.000+08:00"
        }
      }
      ```
    NOTES
    params do
      requires :user_id, type: Integer
    end
    get 'user_wallet_integral' do
      record = PresentedRecord.where(user_id: params[:user_id])
      present record,with: ::Entities::PresentedRecord
    end

    desc '用户余额记录',detail: <<-NOTES.strip_heredoc
      > 请求成功返回信息

      ```json
      {
        {
            "number": "-398.0",
            "reason": "消费",
            "is_effective": false,
            "status": "系统创建",
            "type": null,
            "account": null,
            "desc": null,
            "created_at": "2017-09-20T15:44:07.000+08:00"
        }
      }
      ```
    NOTES
    params do
      requires :user_id, type: Integer
    end
    get 'user_wallet_cash' do
      record = CashRecord.where(user_id: params[:user_id])
      present record,with: ::Entities::CashRecord
    end

    desc '积分提现',detail: <<-NOTES.strip_heredoc
      > 请求成功返回信息

      ```json
      {
        正在更新
      }
      ```
    NOTES
    params do
      requires :user_id, type: Integer
    end
    get 'integral_exchange' do
    end

    desc '积分赠送',detail: <<-NOTES.strip_heredoc
      > 请求成功返回信息

      ```json
      {
        正在更新
      }
      ```
    NOTES
    params do
      requires :user_id, type: Integer
    end
    get 'integral_give' do
    end

  end

end
