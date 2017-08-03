require 'singleton'

module Sdk
  class Idata

    attr_accessor :headers, :url, :username, :password

    def initialize(wechat_user)
      @headers = { "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8" }
      @url = Settings.idata.url
      @username = Settings.idata.username
      @password = Settings.idata.password
      @org_code = Settings.idata.org_code
      @wechat_user = wechat_user
    end

    def exec(method, url, payload)
      url = @url + url
      data = {
        s: payload.to_json,
        u: @username,
        p: @password
      }
      respond = RestClient::Request.execute(
        method: method, url: url, timeout: 120,
        headers: @headers, payload: data
      )
      logger.info(data)
      JSON.parse(respond.body)
    end

    # 会员注册接口。
    def member_register(remark = '')
      if @wechat_user.auth_hash.empty?
        @wechat_user.update_wechat_info
      end

      #用于未抓取到用户的性别
      genderCode = 1 if !@wechat_user.auth_hash["sex"]

      info = {
        "memberID": @wechat_user.open_id,
        "genderCode": genderCode,
        "orgCode": @org_code,
        "recordDateTime": Time.current.strftime('%Y-%m-%d %H:%M:%S'),
        "remark": remark
      }
      
      exec(:post, 'act/memberRegister.do', info)
    end

    # 会员激活服务接口
    # 服务激活序号ID使用 open_id + service_id
    # 默认激活一年
    # service_id 列表见
    # http://test.idata-power.com:9000/api/index.php/home/item/show?item_id=7
    def active_service(service_id)
      info = [{
        "serviceActiveID": @wechat_user.open_id + service_id,
        "memberID": @wechat_user.open_id,
        "serviceID": service_id,
        "startDate": Time.current.strftime('%Y-%m-%d'),
        "endDate": 1.years.from_now.strftime('%Y-%m-%d'),
      }]
      exec(:post, 'act/activeService.do', info)
    end

    # 退订服务
    def unsubscribe_service(service_id)
      info = [{
        "ID": @wechat_user.id,
        "serviceActiveID": @wechat_user.open_id + service_id,
        "memberID": @wechat_user.open_id,
        "serviceID": service_id,
      }]
      exec(:post, 'act/unsubscribeService.do', info)
    end

    # 健康基本信息接口
    # 健康编码见
    # http://test.idata-power.com:9000/api/index.php/home/item/show?item_id=7
    # 格式如下:
    # [{
    #   "code":"ID02.01.001",
    #   "value":"1"
    # },{
    #   "code":"ID02.01.009",
    #   "value":"1"
    # }]
    def person_basic_info(items)
      info = {
        "memberID": @wechat_user.open_id,
        "dateTime": Time.current.strftime('%Y-%m-%d %H:%M:%S'),
        "itemArr": items
      }
      exec(:post, 'act/personBasicInfo.do', info)
    end

    # 日常监测接口
    # 常用监测指标数据上传使用，包含血压、血糖、BMI、睡眠、运动计步、体脂率、血脂、血尿酸、血氧。
    # collect_type: 来源采集方式CODE,1设备监测、2手工录入
    # testBody: 具体参考
    # http://test.idata-power.com:9000/api/index.php/home/item/show?item_id=7
    def daily_detect(test_record_id, test_type, test_body, collect_type = 2, device_type = '')
      info = {
        testRecordID: test_record_id,
        memberID: @wechat_user.open_id,
        testType: test_type,
        testTime: Time.current.strftime('%Y-%m-%d %H:%M:%S'),
        collectType: collect_type ,
        deviceType: device_type,
        testBody: test_body
      }
      exec(:post, 'act/dailyDetect.do', info)
    end

    # 体检记录接口。上传体检记录相关信息。
    # [{
    #   "code": "ID01.07.002.00",
    #   "value": "12.3"
    # }, {
    #   "code": "ID01.07.009.00",
    #   "value": "1"
    # }]
    def exam(record_id, items)
      info = {
        "recordID": record_id,
        "memberID": @wechat_user.open_id,
        "examTime": Time.current.strftime('%Y-%m-%d %H:%M:%S'),
        "uploadTime": Time.current.strftime('%Y-%m-%d %H:%M:%S'),
        "itemArr": items
      }
      exec(:post, 'act/exam.do', info)
    end

    # 检后问询答案上传接口。用于检测血压后回答检后问询答案的上传。
    # 题目编号,题目答案 详见
    # http://test.idata-power.com:9000/api/index.php/home/item/show?item_id=7
    def qa
      info = {
        "memberID": @wechat_user.open_id,
        "qn": qn,
        "answer": answer,
        "se": se
      }
      exec(:post, 'act/qa.do', info)
    end
    

    # 慢病随访接口。上传高血压随访、糖尿病随访
    # 参数详见
    # http://test.idata-power.com:9000/api/index.php/home/item/show?item_id=7
    def chronic(test_record_id, test_type, test_body, collect_type, device_type)
      info = {
        testRecordID: test_record_id,
        memberID: @wechat_user.open_id,
        testType: test_type,
        testTime: Time.current.strftime('%Y-%m-%d %H:%M:%S'),
        collectType: collect_type,
        deviceType: device_type,
        testBody: test_body
      }
      exec(:post, 'act/qa.do', info)
    end

    def logger
      @@logger ||= Logger.new('./log/idata.log')
    end

  end
end
