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
end
