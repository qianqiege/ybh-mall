class IdataRecord < ApplicationRecord
  belongs_to :recordable, polymorphic: true
  belongs_to :wechat_user

  serialize :detail, JSON

  validates :wechat_user, :recordable, presence: true

  after_save :post_data
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
      serviceName: '血糖检测通知'
    },
    '213':{
      serviceID: '213',
      serviceName: '体重检测通知'
    },
    '214':{
      serviceID: '214',
      serviceName: '体脂率检测通知'
    },
    '215':{
      serviceID: '215',
      serviceName: '血脂检测通知'
    },
    '216':{
      serviceID: '216',
      serviceName: '血尿酸检测通知'
    },
    '217':{
      serviceID: '217',
      serviceName: '血氧检测通知'
    },
    '301':{
      serviceID: '301',
      serviceName: '血压监测月报'
    },
    '302':{
      serviceID: '302',
      serviceName: '血糖监测月报'
    },
    '304':{
      serviceID: '304',
      serviceName: '血压周报'
    },
    '305':{
      serviceID: '305',
      serviceName: '体重周报'
    },
    '306':{
      serviceID: '306',
      serviceName: '睡眠周报'
    },
    '307':{
      serviceID: '307',
      serviceName: '运动周报'
    },
    '308':{
      serviceID: '308',
      serviceName: '血糖周报'
    },
    '309':{
      serviceID: '309',
      serviceName: '睡眠月报'
    },
    '310':{
      serviceID: '310',
      serviceName: '运动月报'
    },
    '311':{
      serviceID: '311',
      serviceName: '体重月报'
    },
    '401':{
      serviceID: '401',
      serviceName: '健康西游'
    },
    '701':{
      serviceID: '701',
      serviceName: '血压检后问询报告'
    },
    '702':{
      serviceID: '702',
      serviceName: '高血压随访报告'
    },
    '703':{
      serviceID: '703',
      serviceName: '糖尿病随访报告'
    },
    '704':{
      serviceID: '704',
      serviceName: '血压问卷01服务'
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

  def post_data
    # 这里根据不同类型，添加更多情况


    if self.message.blank?
      #血压
      if recordable.is_a? BloodPressure
        test_body = {
          "highValue": recordable.systolic_pressure,
          "lowValue": recordable.diastolic_pressure,
          # 这里是需要更改
          "pulseValue": "70"
        }
        result = wechat_user.idata.daily_detect(id, 1,test_body)
        Rails.logger.info "@"*20
        Rails.logger.info "上传血压数据到数动力"
        Rails.logger.info result
        if (result['code'] != '0000')
          raise Exception.new(result)
        end
      end

      #体重
      # if recordable.is_a? Weight
      #   test_body = {}
      # end
    end
  end
  

  def send_template_msg
    Rails.logger.info "发送模板消息"
    if (state == 'notified')
      str_message = message.gsub(/(\{.+\}，)|(\{.+\})/, '')
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
          value: "详细健康数据报告请点击查看",
          color: "#FD878E"
        }
      }

      # 这里要换成正确的URL
      url = Settings.weixin.host + "/wechat/idata"
      open_id = wechat_user.open_id
      Rails.logger.info("微信用户的open_id: #{open_id}")

      $wechat_client.send_template_msg(open_id, Settings.idata.template_id, url, "#FD878E", data)
    end
    true
  end
end
