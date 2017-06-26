require 'uri'
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

  # 数动力订阅付款成功回调, 需要路由
  def idata_subscribe
    idata_subscribe = IdataSubscribe.find_by(number: params["merchOrderNo"])
    if(idata_subscribe.present?)
      idata_subscribe.fast_pay.logger.info params
      remote_sign = params[:sign]

      params.delete(:sign)
      params.delete(:action)
      params.delete(:controller)

      local_sign = idata_subscribe.fast_pay.sign(params)
      if (remote_sign == local_sign && params[:fastPayStatus] == "FINISHED")
        idata_subscribe.trade_nos = params["tradeNo"]
        idata_subscribe.pay
        idata_subscribe.save!
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
    Rails.logger.info("数动力回调成功")
    username = Settings.idata.own_username
    password = Settings.idata.own_password
    if (params[:u] == username && params[:p] == password)
      if(params[:url])
        url = URI.decode(params[:url])[2..-1]
        respond = RestClient.get(url, {accept: :json})
        body = JSON.parse(respond.body)
        Rails.logger.info body
        
        record = IdataRecord.find_by(id: body["testRecordID"].to_i)
        Rails.logger.info record

        record1 = IdataRecord.where(id: body["testRecordID"].to_i)
        Rails.logger.info record1

        if (record)
          record.update_attributes(
            message: URI.decode(body["message"]),
            detail: body["detail"],
            service_id: body['serviceID'],
            row_data: body,
            state: 'notified'
          )
          render json: { "code":"0000","msg":"操作成功" }, layout: nil
        end
      else
        render json: {"code":"0000","msg":"数据错误"}, layout: nil
      end
    else
      render json: {"code":"1001","msg":"登陆失败"}, layout: nil
    end
  end
end
