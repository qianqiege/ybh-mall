require 'singleton'

module Sdk
  class FastPay
    include Singleton

    attr_accessor :headers, :url, :secrect_key, :partner_id, :host

    def initialize
      @headers = { "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8" }
      @url = Settings.fast_pay.url
      @secrect_key = Settings.fast_pay.secrect_key
      @partner_id = Settings.fast_pay.partner_id
      @host = Settings.fast_pay.host
    end

    def sign(params)
      sorted_params = params.sort_by{ |k, v| k }.to_h
      query_string = sorted_params.to_query
      to_sign_params = query_string.to_s + @secrect_key

      md5 = Digest::MD5.new
      md5.update(to_sign_params)
      md5.hexdigest
    end

    def sign_params(order, options)
      tradeInfo = [{
        merchOrderNo: order.number,
        tradeAmount: order.price.to_f,
        currency: "CNY",
        goodsName: order.trade_name
      }]

      params = {
        orderNo: order.number,
        partnerId: @partner_id,
        protocol: "httpPost",
        service: options["service"],
        signType: "MD5",
        version: "1.0",
        tradeInfo: tradeInfo.to_s,
        returnUrl: @host + 'mall/orders',
        paymentType: "PAYMENT_TYPE_YJ"
      }

      signed_params = { sign: sign(params) }.merge(params)
      signed_params.sort_by{ |k, v| k }.to_h

    end

    def trade_merge_pay(order, options = { service: "fastPayTradeMergePay"})
      RestClient.post(@url, sign_params(order, options), @headers)
    end

  end
end
