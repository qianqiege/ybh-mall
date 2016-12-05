require 'singleton'

module Sdk
  class FastPay

    attr_accessor :headers, :url, :secrect_key, :partner_id, :host

    def initialize(order)
      @headers = { "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8" }
      @url = Settings.fast_pay.url
      @secrect_key = Settings.fast_pay.secrect_key
      @partner_id = Settings.fast_pay.partner_id
      @host = Settings.fast_pay.host
      @order = order
    end

    def exec(method, url, payload)
      respond = RestClient::Request.execute(
        method: method, url: url, timeout: 120,
        headers: @headers, payload: payload
      )

      # 验证签名
      body = JSON.parse(respond.body)
      sign_params = body["sign"]
      body.delete("sign")

      if(respond.body && sign_params == sign(body))
        body
      else
        {"success": false, resultMessage: "信息被篡改"}
      end
    end

    def sign(params)
      query_string = params.collect do |key, value|
        # JSON.parse 时，0.00 会被转成 0.0
        if key == 'buyerTotalAmount'
          format_value = "%0.2f"% value
          "#{key}=#{format_value}"
        else
          "#{key}=#{value}"
        end
      end.sort * '&'

      to_sign_params = query_string.to_s + @secrect_key

      md5 = Digest::MD5.new
      md5.update(to_sign_params.force_encoding("UTF-8"))
      md5.hexdigest
    end

    def sign_params(options = {})
      salt = rand(999999999..9999999999)
      order_no = "#{Time.current.to_s(:number)}#{salt}"
      # https://apidoc.yiji.com/website/develop_doc.html#公共请求报文
      default_params = {
        partnerId: @partner_id,
        orderNo: order_no,
        signType: "MD5",
        version: "1.0"
      }
      params = default_params.merge(options)
      signed_params = { sign: sign(params) }.merge(params)
      logger.info signed_params
      signed_params.sort_by{ |k, v| k }.to_h
    end

    def trade_merge_pay_params
      salt = rand(999999999..9999999999)
      order_no = "#{Time.current.to_s(:number)}#{salt}"

      tradeInfo = [{
        merchOrderNo: @order.number,
        sellerUserId: @partner_id,
        tradeAmount: @order.price.to_f,
        currency: "CNY",
        goodsName: @order.trade_name
      }]

      options = {
        orderNo: order_no,
        merchOrderNo: @order.number,
        service: "fastPayTradeMergePay",
        tradeInfo: tradeInfo.to_json,
        returnUrl: @host + 'mall/orders',
        notifyUrl: @host + 'notifies/orders',
        paymentType: "PAYMENT_TYPE_YJ"
      }
      sign_params(options)
    end

    # 普通交易支付
    def trade_merge_pay
      exec(:post, @url, trade_merge_pay_params)
    end

    # 交易查询
    def trade_merge_query
      options = {
        service: "multipleTradeMergeQuery",
        tradeNos: @order.trade_nos
      }
      payload = sign_params(options)

      exec(:post, @url, payload)
    end

    # 退款
    def trade_refund
      options = {
        service: "fastPayTradeRefund",
        tradeNo: @order.trade_nos,
        merchOrderNo: @order.number,
        refundAmount: @order.refund_price,
        refundReason: @order.refund_reason
      }
      payload = sign_params(options)

      exec(:post, @url, payload)
    end

    # 新规会员注册
    def register_user
      wechat_user = @order.wechat_user
      if(wechat_user && wechat_user.user)
        options = {
          service: "ppmNewRuleRegisterUser",
          userName: wechat_user.nickname,
          merchOrderNo: @order.number,
          registerUserType: "PERSONAL",
          mobile: wechat_user.user.telphone
        }
        payload = sign_params(options)

        exec(:post, @url, payload)
      else
        {"success": false, resultMessage: "用户未绑定"}
      end
    end

    def logger
      @@logger ||= Logger.new('./log/fast_pay.log')
    end

  end
end
