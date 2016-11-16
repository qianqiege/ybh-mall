class SendSms
  def self.send(phone, code)
    tpl_params = { code: code }
    ChinaSMS.use :yunpian, password: Settings.sms_password
    ChinaSMS.to phone, tpl_params, tpl_id: Settings.sms_tpl_id
  end
end
