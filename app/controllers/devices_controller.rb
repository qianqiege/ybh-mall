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
      idcard = User.find_by(telphone: info["mo"])
      case type
      when "101"
        # 血压
        if !idcard.nil?
          # 如果没有找到手机号对应的UserID，将不绑定UserID
          @blood_pressures = BloodPressure.new(user_id: idcard.id,diastolic_pressure: pressure["pdp"],systolic_pressure: pressure["pcp"],phone: info["mo"],state: state,created_at: info["rsptime"])
          @blood_pressures.save
          if !idcard.nil?
            mall = Sdk::Mall.new
            mall.api_blood_pressure(idcard.identity_card,pressure["pdp"],pressure["pcp"])
          end
        else
          @blood_pressures = BloodPressure.new(diastolic_pressure: pressure["pdp"],systolic_pressure: pressure["pcp"],phone: info["mo"],state: state,created_at: info["rsptime"])
          @blood_pressures.save
        end
      when "102"
        # 血糖
        if !idcard.nil?
          # 如果没有找到手机号对应的UserID，将不绑定UserID
          @blood_glucose = BloodGlucose.new(user_id: idcard.id,value: pressure["bds"],mens_type: pressure["mensType"],phone: info["mo"],state: state,created_at: info["rsptime"],)
          @blood_glucose.save
          idcard = User.find_by(telphone: info["mo"])
          mall = Sdk::Mall.new
          mall.api_blood_glucose(idcard.identity_card,pressure["pds"],pressure["mensType"])
        else
          @blood_glucose = BloodGlucose.new(value: pressure["pds"],mens_type: pressure["mensType"],phone: info["mo"],state: state,created_at: info["rsptime"])
          @blood_glucose.save
        end
      when "103"
        # 体重
        if !idcard.nil?
          @weight = Weight.new(user_id: idcard.id,value:pressure["weight"],phone:info["mo"],state: state,created_at: info["rsptime"])
          @weight.save
          mall = Sdk::Mall.new
          mall.api_weight(idcard.identity_card,pressure["weight"])
        else
          @weight = Weight.new(value:pressure["weight"],phone:info["mo"],state: state,created_at: info["rsptime"])
          @weight.save
        end
      when "104"
        # 体脂
      when "105"
        # 尿酸
        if !idcard.nil?
          @unine = Unine.new(user_id: idcard.id,value:pressure["ua"],phone:info["mo"],state: state,created_at: info["rsptime"])
          @unine.save
          # mall = Sdk::Mall.new
          # mall.api_Unine(idcard.identity_card,pressure["weight"])
        else
          @unine = Unine.new(value:pressure["ua"],phone:info["mo"],state: state,created_at: info["rsptime"])
          @unine.save
        end
      when "106"
        # 血脂
        if !idcard.nil?
          @blood_fat = BloodFat.new(user_id: idcard.id,value:pressure["tc"],phone:info["mo"],state: state,created_at: info["rsptime"])
          @blood_fat.save
          # mall = Sdk::Mall.new
          # mall.api_temperature(idcard.identity_card,pressure["tc"])
        else
          @blood_fat = BloodFat.new(value:pressure["tc"],phone:info["mo"],state: state,created_at: info["rsptime"])
          @blood_fat.save
        end
      when "107"
        # 温度
        if !idcard.nil?
          @api_temperature = Temperature.new(user_id: idcard.id,value:pressure["etg"],phone:info["mo"],state: state,created_at: info["rsptime"])
          @api_temperature.save
          mall = Sdk::Mall.new
          mall.api_temperature(idcard.identity_card,pressure["etg"])
        else
          @api_temperature = Temperature.new(value:pressure["etg"],phone:info["mo"],state: state,created_at: info["rsptime"])
          @api_temperature.save
        end
      else
      end
      response = { success: "200", errmsg: "保存成功" }
      render xml: response.to_xml(root: 'data'), layout: nil
    else
      response = { success: "400", errmsg: "保存失败" }
      render xml: response.to_xml(root: 'data'), layout: nil
    end
  end
end
