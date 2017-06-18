class NotifiesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  # 支付通知回调
  def orders
    order = Order.find_by(number: params["merchOrderNo"])
    if(order.present?)
      order.fast_pay.logger.info params
      remote_sign = params[:sign]

      params.delete(:sign)
      params.delete(:action)
      params.delete(:controller)

      local_sign = order.fast_pay.sign(params)
      if (remote_sign == local_sign && params[:fastPayStatus] == "FINISHED")
        order.trade_nos = params["tradeNo"]
        order.pay
        order.save!
        render json: "success", layout: nil
      else
        render json: "fail", layout: nil
      end
    else
      render json: "fail", layout: nil
    end
  end

  # 充值支付通知回掉
  def deposits
    deposit = Deposit.find_by(number: params["merchOrderNo"])
    if(deposit.present?)
      deposit.fast_pay.logger.info params
      remote_sign = params[:sign]

      params.delete(:sign)
      params.delete(:action)
      params.delete(:controller)

      local_sign = deposit.fast_pay.sign(params)
      if (remote_sign == local_sign && params[:fastPayStatus] == "FINISHED")
        deposit.trade_nos = params["tradeNo"]
        deposit.pay
        deposit.save!
        render json: "success", layout: nil
      else
        render json: "fail", layout: nil
      end
    else
      render json: "fail", layout: nil
    end
  end

  def refund
    # TODO: 退款流程
    render json: "success", layout: nil
  end

  def idata
    username = Settings.idata.own_username
    password = Settings.idata.own_password
    if (params[:u] == username && params[:p] == password)
      # 这里写接受到数据的逻辑
      # 解析url,获取url,并更新数据和状态
      render json: {"code":"0000","msg":"操作成功"}, layout: nil
    else
      render json: {"code":"1001","msg":"登陆失败"}, layout: nil
    end
  end
end
