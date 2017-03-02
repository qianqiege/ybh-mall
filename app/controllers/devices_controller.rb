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
      mall = Sdk::Mall.new
      temporary = TemporaryDatum.where(phone: info["mo"]).limit(1).order(created_at: :desc)
      case type
      when "101"
        # 血压
        if !idcard.nil?
          # 如果没有找到手机号对应的UserID，将不绑定UserID
          @blood_pressures = BloodPressure.new(user_id: idcard.id,diastolic_pressure: pressure["pdp"],systolic_pressure: pressure["pcp"],phone: info["mo"],state: state,created_at: info["rsptime"])
          @blood_pressures.save
          @heart_rate = HeartRate.new(user_id: idcard.id,value: pressure["pm"],phone: info["mo"],state: state,created_at: info["rsptime"])
          @heart_rate.save
          if !temporary[0].nil?
            mall.api_heart_rate(temporary[0].identity_card,pressure["pm"],info["mo"])
            mall.api_blood_pressure(temporary[0].identity_card,pressure["pdp"],pressure["pcp"],info["mo"])
          else
            mall.api_heart_rate(idcard.identity_card,pressure["pm"],info["mo"])
            mall.api_blood_pressure(idcard.identity_card,pressure["pdp"],pressure["pcp"],info["mo"])
          end
        else
          @blood_pressures = BloodPressure.new(diastolic_pressure: pressure["pdp"],systolic_pressure: pressure["pcp"],phone: info["mo"],state: state,created_at: info["rsptime"])
          @blood_pressures.save
          @heart_rate = HeartRate.new(value: pressure["pm"],phone: info["mo"],state: state,created_at: info["rsptime"])
          @heart_rate.save
        end
      when "102"
        # 血糖
        if !idcard.nil?
          # 如果没有找到手机号对应的UserID，将不绑定UserID
          @blood_glucose = BloodGlucose.new(user_id: idcard.id,value: pressure["bds"],mens_type: pressure["mensType"],phone: info["mo"],state: state,created_at: info["rsptime"],)
          @blood_glucose.save
          if !temporary[0].nil?
            mall.api_blood_glucose(temporary[0].identity_card,pressure["bds"],pressure["mensType"],info["mo"])
          else
            mall.api_blood_glucose(idcard.identity_card,pressure["bds"],pressure["mensType"],info["mo"])
          end
        else
          @blood_glucose = BloodGlucose.new(value: pressure["bds"],mens_type: pressure["mensType"],phone: info["mo"],state: state,created_at: info["rsptime"])
          @blood_glucose.save
        end
      when "103"
        # 体重
        if !idcard.nil?
          @weight = Weight.new(user_id: idcard.id,value:pressure["weight"],phone:info["mo"],state: state,created_at: info["rsptime"])
          @weight.save
          if !temporary[0].nil?
            mall.api_weight(temporary[0].identity_card,pressure["weight"],info["mo"])
          else
            mall.api_weight(idcard.identity_card,pressure["weight"],info["mo"])
          end
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
          if !temporary[0].nil?
            mall.api_unine(temporary[0].identity_card,pressure["ua"],info["mo"])
          else
            mall.api_unine(idcard.identity_card,pressure["ua"],info["mo"])
          end
        else
          @unine = Unine.new(value:pressure["ua"],phone:info["mo"],state: state,created_at: info["rsptime"])
          @unine.save
        end
      when "106"
        # 血脂
        if !idcard.nil?
          @blood_fat = BloodFat.new(user_id: idcard.id,value:pressure["tc"],phone:info["mo"],state: state,created_at: info["rsptime"])
          @blood_fat.save
          if !temporary[0].nil?
            mall.api_blood_fat(temporary[0].identity_card,pressure["tc"],info["mo"])
          else
            mall.api_blood_fat(idcard.identity_card,pressure["tc"],info["mo"])
          end
        else
          @blood_fat = BloodFat.new(value:pressure["tc"],phone:info["mo"],state: state,created_at: info["rsptime"])
          @blood_fat.save
        end
      when "107"
        # 温度
        if !idcard.nil?
          @api_temperature = Temperature.new(user_id: idcard.id,value:pressure["etg"],phone:info["mo"],state: state,created_at: info["rsptime"])
          @api_temperature.save
          if !temporary[0].nil?
            mall.api_temperature(temporary[0].identity_card,pressure["etg"],info["mo"])
          else
            mall.api_temperature(idcard.identity_card,pressure["etg"],info["mo"])
          end
        else
          @api_temperature = Temperature.new(value:pressure["etg"],phone:info["mo"],state: state,created_at: info["rsptime"])
          @api_temperature.save
        end
      when '108'
        png_hex = info["param"]["ecgpng"]
        id = info["param"]["id"]

        dir = Rails.root.join('public', 'uploads', 'ecg');
        FileUtils.mkdir_p(dir) unless File.directory?(dir)
        # FIXME: 这里用id做文件名，需要跟对方确认是否唯一，如果不唯一，请对方提供其他标示
        File.open("#{dir}/#{id}.png", "wb"){|fh|
          png_hex.scan(/.{2}/) { |e| fh.putc(e.hex) }
        }
        # FIXME: 这里是图片地址，用于传给慢病
        image_url = helpers.asset_url("uploads/ecg/#{id}.png")
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
