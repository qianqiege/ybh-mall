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
      temporary.each do |temp|
        @user = User.find_by(identity_card: temp.identity_card)
      end
      case type
      when "101"
        # 血压
        if !temporary[0].nil?
          @blood_pressures = BloodPressure.new(diastolic_pressure: pressure["pdp"],systolic_pressure: pressure["pcp"],phone: info["mo"],state: state,created_at: info["rsptime"])
          @heart_rate = HeartRate.new(value: pressure["pm"],phone: info["mo"],state: state,created_at: info["rsptime"])
          if(@user.present?)
            @heart_rate.user_id = @user.id
            @blood_pressures.user_id = @user.id
          end
          @heart_rate.save
          @blood_pressures.save
          if !temporary[0].identity_card.nil?
            mall.api_heart_rate(temporary[0].identity_card,pressure["pm"],info["mo"])
            mall.api_blood_pressure(temporary[0].identity_card,pressure["pdp"],pressure["pcp"],info["mo"])
          end
        elsif !idcard.nil?
          # 如果没有找到手机号对应的UserID，将不绑定UserID
          @blood_pressures = BloodPressure.new(user_id: idcard.id,diastolic_pressure: pressure["pdp"],systolic_pressure: pressure["pcp"],phone: info["mo"],state: state,created_at: info["rsptime"])
          if(@user.present?)
            @heart_rate.user_id = @user.id
            @blood_pressures.user_id = @user.id
          end
          @heart_rate = HeartRate.new(user_id: idcard.id,value: pressure["pm"],phone: info["mo"],state: state,created_at: info["rsptime"])
          @heart_rate.save
          @blood_pressures.save
          if !idcard.nil?
            mall.api_heart_rate(idcard.identity_card,pressure["pm"],info["mo"])
            mall.api_blood_pressure(idcard.identity_card,pressure["pdp"],pressure["pcp"],info["mo"])
          end
        end
      when "102"
        # 血糖
        value = pressure["bds"].to_i / 10
        if !temporary[0].nil?
          @blood_glucose = BloodGlucose.new(value: value,mens_type: pressure["mensType"],phone: info["mo"],state: state,created_at: info["rsptime"])
          if(@user.present?)
            @blood_glucose.user_id = @user.id
          end
          @blood_glucose.save
          if !temporary[0].identity_card.nil?
            mall.api_blood_glucose(temporary[0].identity_card,value,pressure["mensType"],info["mo"])
          end
        elsif !idcard.nil?
          # 如果没有找到手机号对应的UserID，将不绑定UserID
          @blood_glucose = BloodGlucose.new(user_id: idcard.id,value: pressure["bds"],mens_type: pressure["mensType"],phone: info["mo"],state: state,created_at: info["rsptime"],)
          if(@user.present?)
            @blood_glucose.user_id = @user.id
          end
          @blood_glucose.save
          if !idcard.identity_card.nil?
            mall.api_blood_glucose(idcard.identity_card,pressure["bds"],pressure["mensType"],info["mo"])
          end
        end
      when "103"
        # 体重
        if !temporary[0].nil?
          @weight = Weight.new(value:pressure["weight"],phone:info["mo"],state: state,created_at: info["rsptime"])
          if(@user.present?)
            @weight.user_id = @user.id
          end
          @weight.save
          if !temporary[0].identity_card.nil?
            mall.api_weight(temporary[0].identity_card,pressure["weight"],info["mo"])
          end
        elsif !idcard.nil?
          @weight = Weight.new(user_id: idcard.id,value:pressure["weight"],phone:info["mo"],state: state,created_at: info["rsptime"])
          if(@user.present?)
            @weight.user_id = @user.id
          end
          @weight.save
          if !idcard.identity_card.nil?
            mall.api_weight(idcard.identity_card,pressure["weight"],info["mo"])
          end
        end
      when "104"
        # 体脂
      when "105"
        # 尿酸
        if !temporary[0].nil?
          @unine = Unine.new(value:pressure["ua"],phone:info["mo"],state: state,created_at: info["rsptime"])
          if(@user.present?)
            @unine.user_id = @user.id
          end
          @unine.save
          if !temporary[0].identity_card.nil?
            mall.api_unine(temporary[0].identity_card,pressure["ua"],info["mo"])
          end
        elsif !idcard.nil?
          @unine = Unine.new(user_id: idcard.id,value:pressure["ua"],phone:info["mo"],state: state,created_at: info["rsptime"])
          if(@user.present?)
            @unine.user_id = @user.id
          end
          @unine.save
          if !idcard.identity_card.nil?
            mall.api_unine(idcard.identity_card,pressure["ua"],info["mo"])
          end
        end
      when "106"
        # 血脂
        if !temporary[0].identity_card.nil?
          mall.api_blood_fat(temporary[0].identity_card,pressure["tc"],info["mo"])
          @blood_fat = BloodFat.new(value:pressure["tc"],phone:info["mo"],state: state,created_at: info["rsptime"])
          if(@user.present?)
            @blood_fat.user_id = @user.id
          end
          @blood_fat.save
          # if !idcard.nil?
          #   @blood_fat = BloodFat.new(user_id: idcard.id,value:pressure["tc"],phone:info["mo"],state: state,created_at: info["rsptime"])
          #   if(@user.present?)
          #     @blood_fat.user_id = @user.id
          #   end
          #   @blood_fat.save
          #   if !idcard.identity_card.nil?
          #     mall.api_blood_fat(idcard.identity_card,pressure["tc"],info["mo"])
          #   end
          # end
        end
      when "107"
        # 温度
        if !temporary[0].nil?
          @api_temperature = Temperature.new(value:pressure["etg"],phone:info["mo"],state: state,created_at: info["rsptime"])
          if(@user.present?)
            @api_temperature.user_id = @user.id
          end
          @api_temperature.save
          if !temporary[0].identity_card.nil?
            mall.api_temperature(temporary[0].identity_card,pressure["etg"],info["mo"])
          end
        elsif !idcard.nil?
          @api_temperature = Temperature.new(user_id: idcard.id,value:pressure["etg"],phone:info["mo"],state: state,created_at: info["rsptime"])
          if(@user.present?)
            @api_temperature.user_id = @user.id
          end
          @api_temperature.save
          if !idcard.identity_card.nil?
            mall.api_temperature(idcard.identity_card,pressure["etg"],info["mo"])
          end
        end
      when '108'
        png_hex = info["param"]["ecgpng"]
        # id = Digest::MD5.hexdigest(info["param"]["id"])

        # dir = Rails.root.join('public', 'uploads', 'ecg');
        # FileUtils.mkdir_p(dir) unless File.directory?(dir)
        # FIXME: 这里用id做文件名，需要跟对方确认是否唯一，如果不唯一，请对方提供其他标示
        # File.open("#{dir}/#{id}.png", "wb"){|fh|
          # png_hex.scan(/.{2}/) { |e| fh.putc(e.hex) }
        # }
        # FIXME: 这里是图片地址，用于传给慢病
        # image_url = helpers.asset_url("uploads/ecg/#{id}.png")
        if !temporary[0].nil?
          mall.api_ECG(temporary[0].identity_card,png_hex,info["mo"])
          @ecg = Ecg.new(user_id: temporary[0].id,url: png_hex, phone: info["mo"])
          if @ecg.save
          end
        end
      else
        response = { success: "404", errmsg: "没有找到对象" }
        render xml: response.to_xml(root: 'data'), layout: nil
      end
      response = { success: "200", errmsg: "保存成功" }
      render xml: response.to_xml(root: 'data'), layout: nil
    else
      response = { success: "400", errmsg: "保存失败" }
      render xml: response.to_xml(root: 'data'), layout: nil
    end
  end
end
