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
      body = JSON.parse(respond.body.gsub /\d+\.\d{2}/, '"\0"')
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
        if (value.instance_of? Array) || (value.instance_of? Hash)
          "#{key}=#{value.to_json.gsub(/\"\d+\.\d{2}\"/){ |m| "#{m.gsub(/\"/, '')}" }}"
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

    # 生成普通交易支付参数
    # PAYMENT_TYPE_WECHAT
    # PAYMENT_TYPE_YJ
    def trade_merge_pay_params(pay_type = "PAYMENT_TYPE_YJ")
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
        paymentType: pay_type
      }

      options[:openid] =  @order.wechat_user.open_id

      sign_params(options)
    end

    # 生成用户充值交易支付参数
    # PAYMENT_TYPE_WECHAT
    # PAYMENT_TYPE_YJ
    def trade_merge_pay_params_deposit(pay_type = "PAYMENT_TYPE_YJ")
      salt = rand(999999999..9999999999)
      order_no = "#{Time.current.to_s(:number)}#{salt}"

      tradeInfo = [{
        merchOrderNo: @order.number,
        sellerUserId: @partner_id,
        tradeAmount: @order.price.to_f,
        currency: "CNY",
        goodsName: "账户充值"
      }]

      options = {
        orderNo: order_no,
        merchOrderNo: @order.number,
        service: "fastPayTradeMergePay",
        tradeInfo: tradeInfo.to_json,
        returnUrl: @host + 'user/transaction',
        notifyUrl: @host + 'notifies/deposits',
        paymentType: pay_type
      }

      options[:openid] =  User.find(@order.user_id).wechat_user.open_id

      sign_params(options)
    end

    # 生成百万创客付款交易支付参数
    # PAYMENT_TYPE_WECHAT
    # PAYMENT_TYPE_YJ
    def trade_merge_pay_params_plan(pay_type = "PAYMENT_TYPE_YJ")
      salt = rand(999999999..9999999999)
      order_no = "#{Time.current.to_s(:number)}#{salt}"

      tradeInfo = [{
        merchOrderNo: @order.number,
        sellerUserId: @partner_id,
        tradeAmount: @order.price.to_f,
        currency: "CNY",
        goodsName: "百万创客计划"
      }]

      options = {
        orderNo: order_no,
        merchOrderNo: @order.number,
        service: "fastPayTradeMergePay",
        tradeInfo: tradeInfo.to_json,
        returnUrl: @host + 'wecaht/makers/plan',
        notifyUrl: @host + 'notifies/plans',
        paymentType: pay_type
      }

      options[:openid] =  User.find(@order.user_id).wechat_user.open_id

      sign_params(options)
    end



    # 生成普通交易(数动力订阅服务)支付参数
    # PAYMENT_TYPE_WECHAT
    # PAYMENT_TYPE_YJ
    def trade_merge_pay_params_idata_subscribe(pay_type = "PAYMENT_TYPE_YJ")
      salt = rand(999999999..9999999999)
      order_no = "#{Time.current.to_s(:number)}#{salt}"

      tradeInfo = [{
        merchOrderNo: @order.number,
        sellerUserId: @partner_id,
        tradeAmount: @order.price.to_f,
        currency: "CNY",
        goodsName: "动态健康数据报告订阅"
      }]

      options = {
        orderNo: order_no,
        merchOrderNo: @order.number,
        service: "fastPayTradeMergePay",
        tradeInfo: tradeInfo.to_json,
        returnUrl: @host + 'user/moving_health_data',
        notifyUrl: @host + 'notifies/idata_subscribe',
        paymentType: pay_type
      }
      options[:openid] =  User.find(@order.user_id).wechat_user.open_id

      sign_params(options)
    end


    # 生成用户充值交易(一盏明灯)支付参数
    # PAYMENT_TYPE_WECHAT
    # PAYMENT_TYPE_YJ
    def trade_merge_pay_params_donation_record(pay_type = "PAYMENT_TYPE_YJ")
      salt = rand(999999999..9999999999)
      order_no = "#{Time.current.to_s(:number)}#{salt}"

      tradeInfo = [{
        merchOrderNo: @order.order_number,
        sellerUserId: @partner_id,
        tradeAmount: @order.price.to_f,
        currency: "CNY",
        goodsName: "一盏明灯捐款"
      }]

      options = {
        orderNo: order_no,
        merchOrderNo: @order.order_number,
        service: "fastPayTradeMergePay",
        tradeInfo: tradeInfo.to_json,
        returnUrl: @host + 'wechat/light',
        notifyUrl: @host + 'notifies/donation_record',
        paymentType: pay_type
      }

      options[:openid] =  User.find(@order.user_id).wechat_user.open_id

      sign_params(options)
    end

    # 普通交易支付
    # PAYMENT_TYPE_WECHAT
    # PAYMENT_TYPE_YJ
    # def trade_merge_pay(pay_type = "PAYMENT_TYPE_YJ")
    #   exec(:post, @url, trade_merge_pay_params(pay_type))
    # end

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
        notifyUrl: @host + 'notifies/refund',
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
