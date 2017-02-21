class DevicesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def putmessage
    device = Sdk::Device.new
    result = request.body.read
    if result.include?("jkezData")
      jkezData = result.gsub /jkezData=/, ''
      data = device.decryption(jkezData)
      pressure = data["msg"]["param"]
      info = data["msg"]
      type = info["type"]
      state = "设备上传"
      case type
      when "101"
        # 血压
        @blood_pressures = BloodPressure.new(diastolic_pressure: pressure["pdp"],systolic_pressure: pressure["pcp"],phone: info["mo"],state: state,created_at: info["rsptime"])
        @blood_pressures.save
        idcard = User.find_by(telphone: info["mo"])
        if !idcard.nil?
          mall = Sdk::Mall.new
          mall.api_blood_pressure(idcard.identity_card,pressure["pdp"],pressure["pcp"])
        end
      when "102"
        # 血糖
      when "103"
        # 体重
      when "104"
        # 体脂
      when "105"
        # 尿酸
      when "106"
        # 血脂
      when "107"
        # 温度
      else
      end
      response = { success: 200, errmsg: "保存成功" }
      render xml: response.to_xml(root: 'data'), layout: nil
    else
      response = { success: 400, errmsg: "保存失败" }
      render xml: response.to_xml(root: 'data'), layout: nil
    end
  end
end
