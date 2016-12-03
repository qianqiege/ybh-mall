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
      JSON.parse(respond.body)
    end

    def sign(params)
      sorted_params = params.sort_by{ |k, v| k }.to_h
      query_string = sorted_params.to_query
      to_sign_params = query_string.to_s + @secrect_key

      md5 = Digest::MD5.new
      md5.update(to_sign_params)
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
      signed_params.sort_by{ |k, v| k }.to_h
    end

    # 普通交易支付
    def trade_merge_pay_params(options)
      tradeInfo = [{
        merchOrderNo: @order.number,
        tradeAmount: @order.price.to_f,
        currency: "CNY",
        goodsName: @order.trade_name
      }]

      options = {
        orderNo: @order.number,
        service: options["service"],
        tradeInfo: tradeInfo.to_s,
        returnUrl: @host + 'mall/orders',
        paymentType: "PAYMENT_TYPE_YJ"
      }
      sign_params(options)
    end

    def trade_merge_pay(options = { service: "fastPayTradeMergePay"})
      exec(:post, @url, trade_merge_pay_params(options))
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
        refundAmount: @order.refund_price,
        refundReason: "123"
      }
      payload = sign_params(options)

      exec(:post, @url, payload)
    end

  end
end
