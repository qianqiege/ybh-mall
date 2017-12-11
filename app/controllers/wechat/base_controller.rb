# coding: utf-8
module Wechat
  class BaseController < ApplicationController
    layout "wechat"

    helper_method :current_user, :verification

    before_action :get_wechat_sns_info, :current_user, :verification

    private
    def get_wechat_sns_info
      # enable to skip wechat auth for fast local development
      # by starting rails server using `SKIP_WECHAT_AUTH=1 rails s`


      if ENV['SKIP_WECHAT_AUTH'] && Rails.env.development?
        session[:wechat_open_id] ||= (params[:wechat_open_id] || Time.current.to_i)
        return
      end

      if session[:wechat_open_id].blank? && params[:code]
        sns_info = $wechat_client.get_oauth_access_token(params[:code])
        Rails.logger.info("sns_info"*20)
        Rails.logger.info(params[:code])
        Rails.logger.info(sns_info.result)

        # sns_info.result
        # 正确时返回的JSON数据包如下：
        # ```
        #   {
        #      "access_token":"ACCESS_TOKEN",
        #      "expires_in":7200,
        #      "refresh_token":"REFRESH_TOKEN",
        #      "openid":"OPENID",
        #      "scope":"SCOPE",
        #      "unionid": "o6_bmasdasdsad6_2sgVt7hMZOPfL"
        #   }
        # ```
        # 错误时微信会返回JSON数据包如下（示例为Code无效错误）：
        # ```
        #   {"errcode":40029,"errmsg":"invalid code"}
        # ```
        # reference: http://mp.weixin.qq.com/wiki/17/c0f37d5704f0b64713d5d2c37b468d75.html
        Rails.logger.debug("Weixin oauth2 response: #{sns_info.result}")

        # 重复使用相同一个code调用时：
        if sns_info.result["errcode"] != "40029"
          result = sns_info.result
          session[:wechat_open_id] = result["openid"]

          # user_info.result
          #
          # 正确时返回的JSON数据包如下：
          # {
          #    "openid":" OPENID",
          #    "nickname": NICKNAME,
          #    "sex":"1",
          #    "province":"PROVINCE"
          #    "city":"CITY",
          #    "country":"COUNTRY",
          #    "headimgurl":"http://wx.qlogo.cn/mmopen/g3MonUZtNHkdmzicIlibx6iaFqAc56vxLSUfpb6n5WKSYVY0ChQKkiaJSgQ1dZuTOgvLLrhJbERQQ4eMsv84eavHiaiceqxibJxCfHe/46",
          #    "privilege":[
          #       "PRIVILEGE1"
          #       "PRIVILEGE2"
          #     ],
          #     "unionid": "o6_bmasdasdsad6_2sgVt7hMZOPfL"
          # }
          #
          # 错误时微信会返回JSON数据包如下（示例为openid无效）:
          # {"errcode":40003,"errmsg":" invalid openid "}
          # reference: http://mp.weixin.qq.com/wiki/17/c0f37d5704f0b64713d5d2c37b468d75.html
          user_info = $wechat_client.get_oauth_userinfo(result['openid'], result['access_token'])
          Rails.logger.info("@"*40)
          Rails.logger.info(user_info.inspect)
          Rails.logger.info("&"*40)
          user = WechatUser.find_or_initialize_by open_id: result['openid']
          user.access_token_info = result
          user.set_userinfo(user_info.result) if user_info.result['errcode'].blank?
          user.save
        else
          @error_message = sns_info.result["errmsg"]
        end
      end

      # http://mp.weixin.qq.com/wiki/17/c0f37d5704f0b64713d5d2c37b468d75.html
      # 1、以snsapi_base为scope发起的网页授权，是用来获取进入页面的用户的openid的，并且是静默授权并自动跳转到回调页的。用户感知的就是直接进入了回调页（往往是业务页面）
      # 2、以snsapi_userinfo为scope发起的网页授权，是用来获取用户的基本信息的。但这种授权需要用户手动同意，并且由于用户同意过，所以无须关注，就可在授权后获取该用户的基本信息。

      if should_get_userinfo?
        # 进入需要获取用户详细信息,当前没有用户或者还未进行授权的用户，通过snsapi_userinfo授权，获取用户详细信息
        if !current_user || current_user && !current_user.is_wechat_authorized?
          Rails.logger.info("进行snsapi_userinfo授权")
          redirect_to wechat_reauthorize_url(request.url, 'snsapi_userinfo')
        end
      else
        # 进入不需要获取用户详细信息页面且当前没有用户, 只需获取open_id
        if !current_user
          Rails.logger.info("进行snsapi_base授权")
          redirect_to wechat_reauthorize_url(request.url, "snsapi_base")
        end
      end

      # 其他情况不需要处理

    end

    def current_user
      if session[:wechat_open_id].present?
        @current_user ||= WechatUser.find_by(open_id: session[:wechat_open_id])
      end
      # WechatUser.find(1890)
    end

    def verification
      @user = WechatUser.where(id:current_user.id).take
    end

    def wechat_reauthorize_url(url, scope)
      session[:wechat_open_id] = nil
      $wechat_client.authorize_url(url, scope)
    end

    # TODO: 这里需要改成绑定页面，绑定页面会获取比较多的信息
    def should_get_userinfo?
      params[:controller] == "wechat/home" && params[:action] == "index"
    end
  end
end
