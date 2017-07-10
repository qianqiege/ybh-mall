class IdataRecord < ApplicationRecord
  belongs_to :recordable, polymorphic: true
  belongs_to :wechat_user

  serialize :detail, JSON

  validates :wechat_user, :recordable, presence: true

  after_create_commit :whether_post_data
  after_update :send_template_msg

  # 这里需要补充词典内容
  DICT = {
    '107': {
      serviceID: '107',
      serviceName: '健康方案悦享版'
    },
    '211':{
      serviceID: '211',
      serviceName: '血压检测通知',
      serviceInfo: '你好，你的血压报告已生成'
    },
    '212':{
      serviceID: '212',
      serviceName: '血糖检测通知',
      serviceInfo: '你好，你的血糖报告已生成'
    },
    '213':{
      serviceID: '213',
      serviceName: '体重检测通知',
      serviceInfo: '你好，你的体重报告已生成'
    },
    '214':{
      serviceID: '214',
      serviceName: '体脂率检测通知',
      serviceInfo: '你好，你的体脂率报告已生成'
    },
    '215':{
      serviceID: '215',
      serviceName: '血脂检测通知',
      serviceInfo: '你好，你的血脂报告已生成'
    },
    '216':{
      serviceID: '216',
      serviceName: '血尿酸检测通知',
      serviceInfo: '你好，你的血尿酸报告已生成'
    },
    '217':{
      serviceID: '217',
      serviceName: '血氧检测通知',
      serviceInfo: '你好，你的血氧报告已生成'
    },
    '301':{
      serviceID: '301',
      serviceName: '血压监测月报',
      serviceInfo: '你好，你的血压监测月报已生成'
    },
    '302':{
      serviceID: '302',
      serviceName: '血糖监测月报',
      serviceInfo: '你好，你的血糖监测月报已生成'
    },
    '304':{
      serviceID: '304',
      serviceName: '血压周报',
      serviceInfo: '你好，你的血压周报已生成'
    },
    '305':{
      serviceID: '305',
      serviceName: '体重周报',
      serviceInfo: '你好，你的体重周报已生成'
    },
    '306':{
      serviceID: '306',
      serviceName: '睡眠周报',
      serviceInfo: '你好，你的睡眠周报已生成'
    },
    '307':{
      serviceID: '307',
      serviceName: '运动周报',
      serviceInfo: '你好，你的运动周报已生成'
    },
    '308':{
      serviceID: '308',
      serviceName: '血糖周报',
      serviceInfo: '你好，你的血糖周报已生成'
    },
    '309':{
      serviceID: '309',
      serviceName: '睡眠月报',
      serviceInfo: '你好，你的睡眠月报已生成'
    },
    '310':{
      serviceID: '310',
      serviceName: '运动月报',
      serviceInfo: '你好，你的运动月报已生成'
    },
    '311':{
      serviceID: '311',
      serviceName: '体重月报',
      serviceInfo: '你好，你的体重月报已生成'
    },
    '401':{
      serviceID: '401',
      serviceName: '健康西游',
      serviceInfo: '你好，你的健康西游已生成'
    },
    '701':{
      serviceID: '701',
      serviceName: '血压检后问询报告',
      serviceInfo: '你好，你的血压检后问询报告已生成'
    },
    '702':{
      serviceID: '702',
      serviceName: '高血压随访报告',
      serviceInfo: '你好，你的高血压随访报告已生成'
    },
    '703':{
      serviceID: '703',
      serviceName: '糖尿病随访报告',
      serviceInfo: '你好，你的糖尿病随访报告已生成'
    },
    '704':{
      serviceID: '704',
      serviceName: '血压问卷01服务',
      serviceInfo: '你好，你的血压问卷01服务报告已生成'
    }
  }

  include AASM
  aasm column: :state do
    # 初始状态
    state :pending, initial: true

    # 收到通知
    state :notified

    event :notice do
      transitions from: :pending, to: :notified
      after do
        send_template_msg
      end
    end
  end


  def self.dict
    DICT
  end

  private

  #判断是否向数动力传递数据
  def whether_post_data

    #各项分类的服务id
    blood_pressure_service_ids = ["211", "301", "304"]
    blood_glucose_service_ids = ["212", "302", "308"]
    blood_fat_service_ids = ["215"]
    weight_service_ids = ["213", "305", "311"]
    unine_service_ids = ["216"]
    other_service_ids = ["107", "401"]


    #拿到用户已经付款后的数动力订阅服务列表
    user_idata_subscribe = UserIdataSubscribe.find_by(user_id: wechat_user.user_id)
    
    Rails.logger.info "@"*20
    Rails.logger.info user_idata_subscribe.inspect


    if !user_idata_subscribe.blank?
      
      #清除原来单个元素为字符串的数组(测试数据)
      user_idata_subscribe.list.each do |f|
        if f.class == String
          user_idata_subscribe.list.clear
          return
        end
      end


      user_subscribe_list = user_idata_subscribe.list.pluck(:service_id).uniq
      
      case recordable_type
      when "BloodPressure"
        if (user_subscribe_list&blood_pressure_service_ids).length != 0 || user_subscribe_list.include?("107")
          if recordable_type != "RegularReport"
            post_data
          end
        end
      when "BloodGlucose"
        if (user_subscribe_list&blood_glucose_service_ids).length != 0 || user_subscribe_list.include?("107")
          if recordable_type != "RegularReport"
            post_data
          end
        end
      when "BloodFat"
        if (user_subscribe_list&blood_fat_service_ids).length != 0 || user_subscribe_list.include?("107")
          if recordable_type != "RegularReport"
            post_data
          end
        end
      when "Weight"
        if (user_subscribe_list&weight_service_ids).length != 0 || user_subscribe_list.include?("107")
          if recordable_type != "RegularReport"
            post_data
          end
        end
      when "Unine"
        if (user_subscribe_list&unine_service_ids).length != 0 || user_subscribe_list.include?("107")
          if recordable_type != "RegularReport"
            post_data
          end
        end  
      end

    else
      return
    end

  end


  def post_data
    # 这里根据不同类型，添加更多情况

    
      #血压
      if recordable.is_a? BloodPressure
        test_body = {
          "highValue": recordable.systolic_pressure,
          "lowValue": recordable.diastolic_pressure,
          # 这里是需要更改
          "pulseValue": recordable.heart
        }
        record = IdataRecord.find_by(id: self.id)
        Rails.logger.info record.inspect
        Rails.logger.info IdataRecord.pluck(:id)
        result = wechat_user.idata.daily_detect(id, 1,test_body)
        Rails.logger.info "@"*20
        Rails.logger.info "上传血压数据到数动力"
        Rails.logger.info result
        if (result['code'] != '0000')
          raise Exception.new(result)
        end
      end

       #血糖
       if recordable.is_a? BloodGlucose
         test_body = {
           "sugarValue": recordable.value,
           "typeDetailCode": recordable.mens_type 
         }
         result = wechat_user.idata.daily_detect(id, 2, test_body)
         if (result['code'] != '0000')
           raise Exception.new(result)
         end
       end

      #血脂
      if recordable.is_a? BloodFat
        test_body = {
          "cholValue": recordable.value
        }
        result = wechat_user.idata.daily_detect(id, 7, test_body)
        if (result['code'] != '0000')
          raise Exception.new(result)
        end
      end

      # 尿酸
       if recordable.is_a? Unine
         test_body = {
           "buaValue": (recordable.value*100).to_i
         }
         result = wechat_user.idata.daily_detect(id, 8, test_body)
         if (result['code'] != '0000')
           raise Exception.new(result)
         end
       end

       #BMI
       if recordable.is_a? Weight
        test_body = {
          "hightVlaue": recordable.height,
          "weightValue": recordable.value
        }
        result = wechat_user.idata.daily_detect(id, 3, test_body)
        if (result['code'] != '0000')
          raise Exception.new(result)
        end
      end
    
  end
  

  def send_template_msg
    Rails.logger.info "发送模板消息"
    if (state == 'notified')
      str_message = message.gsub(/(\{.+\}，)|(\{.+\})/, '')

      #所有月报周报的service_id
      month_week_subscribe_id_list = ["301", "302", "304", "305", "308", "311", "107", "401"]

      #判断是否为定时报告
      if month_week_subscribe_id_list.include?(service_id)


          sugguestion = detail["overview"]? detail["overview"] : detail["bgControlAlert"]
          if service_id == "305"
            sugguestion = detail["evaluateDesc"]
          elsif service_id == "311"
            sugguestion = detail["suggestionWave"]
          elsif ["107", "401"].include?(service_id)
            sugguestion = "请点击详情查看详细信息"
          end


          data = {
            first: {
              value: "#{wechat_user.nickname} #{DICT[service_id.to_sym][:serviceInfo]}",
              color: "#FD878E"
            },
            keyword1: {
              value: DICT[service_id.to_sym][:serviceName],
              color: "#173177"
            },
            keyword2: {
              value: Time.current.strftime('%Y-%m-%d %H:%M:%S'),
              color: "#173177"
            },
            keyword3: {
              value: sugguestion,
              color: "#173177"
            },
            remark: {
              value: "",
              color: "#FD878E"
            }
          } 

          url = Settings.weixin.host + "/user/show_week_or_month_report?id=#{id}"


      else
          data = {
            first: {
              value: "#{wechat_user.nickname} #{DICT[service_id.to_sym][:serviceInfo]}",
              color: "#FD878E"
            },
            keyword1: {
              value: DICT[service_id.to_sym][:serviceName],
              color: "#173177"
            },
            keyword2: {
              value: Time.current.strftime('%Y-%m-%d %H:%M:%S'),
              color: "#173177"
            },
            keyword3: {
              value: str_message,
              color: "#173177"
            },
            remark: {
              value: "",
              color: "#FD878E"
            }
          }

          url = Settings.weixin.host + "/user/data_home"
      end

      
      open_id = wechat_user.open_id

      #调试用代码，可删除
      Rails.logger.info data.inspect
      Rails.logger.info Settings.idata.template_id
      Rails.logger.info $wechat_client.inspect
      Rails.logger.info("微信用户的open_id: #{open_id}")
      Rails.logger.info url
      

      Rails.logger.info $wechat_client.send_template_msg(open_id, Settings.idata.template_id, url, "#FD878E", data)
    end
    true
  end
end
