# NOTE: 需要在云片网后台添加服务器IP白名单和添加签名和模版并通过审核才能发送信息

ChinaSMS.use :yunpian, password: Settings.sms_password
ChinaSMS.class_eval do
  def self.debug
    Rails.env.development? || Rails.env.test?
  end

  # NOTE: remember to rescue SocketError when using this method
  # tpl_params = { code: code }
  def self.send_verify_msg(phone, tpl_params, forceSend = false)
    if !forceSend && self.debug
      Rails.logger.info "send '【公司名称】: 你的验证码是 #{tpl_params[:code]}' to mobile: #{phone}"
    else
      to(phone, tpl_params, tpl_id: Settings.sms_tpl_id)
    end
  end
end
