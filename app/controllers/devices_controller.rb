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
        @blood_pressures = BloodPressure.new(diastolic_pressure: pressure["lat"],systolic_pressure: pressure["lng"],phone: info["mo"],state: state,created_at: info["rsptime"])
        @blood_pressures.save
        idcard = User.find_by(telphone: info["mo"])
        if !idcard.nil?
          mall = Sdk::Mall.new
          mall.api_blood_pressure(idcard.identity_card,pressure["lat"],pressure["lng"])
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
      render json: "success", layout: nil
    else
      render json: "fail", layout: nil
    end
  end
end
