class API::V1::User < API

  namespace :user, desc: '用户相关' do

    desc '用户信息',detail: <<-NOTES.strip_heredoc
      > 请求成功返回信息

      ```json
      {
        "id": 2,
        "access_token": null,
        "expires_at": null,
        "telphone": "13823767270",
        "identity_card": "210282199809088111",
        "id_number": "",
        "name": "肖辉周（正式）",
        "invitation_card": "9898989898",
        "invitation_id": null,
        "email": "river@ybyt.ccc",
        "type": "Patient",
        "status": "Staff",
        "lamp_number": 1,
        "is_partner": null,
        "staff_type": "R&D",
        "parallel_shop_id": null
      }
      ```
      > 请求失败返回信息

      ```json
      {
        "error_message": "未找到该用户",
        "error_code": 401
      }
      ```
    NOTES
    params do
      requires :user_id, type: Integer
    end
    get 'user_info' do
      user_info = User.find(params[:user_id])
      present user_info,with: ::Entities::User
    end

    desc '微信用户信息',detail: <<-NOTES.strip_heredoc
      > 请求成功返回信息

      ```json
      {
        "id": 2,
        "nickname": "久伴",
        "headimgurl": "http://wx.qlogo.cn/mmhead/FB4omYLIWgia4SpzpD5ib4ydazhpqSD7GBzuBKwOmdkcc/0"
      }
      ```
      > 请求失败返回信息

      ```json
      {
        "error_message": "未找到该微信用户",
        "error_code": 401
      }
      ```
    NOTES
    params do
      requires :user_id, type: Integer
    end
    get 'wechat_user_info' do
      wechat_user = WechatUser.find_by(user_id: params[:user_id])
      present wechat_user,with: ::Entities::WechatUser
    end

    desc '用户身份信息',detail: <<-NOTES.strip_heredoc
      > 请求成功返回信息

      ```json
      {
         "id": 67,
         "work_province": null,
         "work_city": null,
         "work_street": null,
         "resident_province": null,
         "resident_city": null,
         "resident_street": null,
         "identity": "user",
         "state": "pending",
         "desc": null,
         "user_id": 2,
         "created_at": "2017-11-20T16:52:10.000+08:00",
         "updated_at": "2017-11-20T16:52:10.000+08:00",
         "image": {
             "url": "/assets/fallback/default-1b9f5ae7db9f85360b0fde3d78b9c6ec8d0d1cfa27405cba77264d938c6374b0.png",
             "product_icon": {
                 "url": "/fallback/product_icon_default.png"
             }
         },
         "score": null,
         "ranking": null,
         "doctor_number": null,
         "doctor_image": {
             "url": "/assets/fallback/default-1b9f5ae7db9f85360b0fde3d78b9c6ec8d0d1cfa27405cba77264d938c6374b0.png",
             "product_icon": {
                 "url": "/fallback/product_icon_default.png"
             }
         },
         "education_image": {
             "url": "/assets/fallback/default-1b9f5ae7db9f85360b0fde3d78b9c6ec8d0d1cfa27405cba77264d938c6374b0.png",
             "product_icon": {
                 "url": "/fallback/product_icon_default.png"
             }
         },
         "other_image": {
             "url": "/assets/fallback/default-1b9f5ae7db9f85360b0fde3d78b9c6ec8d0d1cfa27405cba77264d938c6374b0.png",
             "product_icon": {
                 "url": "/fallback/product_icon_default.png"
             }
         },
         "magor": null,
         "info": null
      }
      ```
      > 请求失败返回信息

      ```json
      {
        "error_message": "未找到对应的身份信息",
        "error_code": 401
      }
      ```
    NOTES
    params do
      requires :user_id, type: Integer
    end
    get 'user_info_review' do
      user_info_reviews = UserInfoReview.find_by(user_id: params[:user_id])
    end

    desc '更改或申请用户身份信息',detail: <<-NOTES.strip_heredoc
      > 请求成功返回信息

      ```json
      {
        "id": 2,
        "nickname": "久伴",
        "headimgurl": "http://wx.qlogo.cn/mmhead/FB4omYLIWgia4SpzpD5ib4ydazhpqSD7GBzuBKwOmdkcc/0"
      }
      ```
      > 请求失败返回信息

      ```json
      {
        "error_message": "未找到该微信用户",
        "error_code": 401
      }
      ```
    NOTES
    params do
      requires :user_id, type: Integer
    end
    put 'edit_user_info_review' do
    end

    desc '新建用户',detail: <<-NOTES.strip_heredoc
      > 请求成功返回信息

      ```json
      {
        "id": 2,
        "telphone": "138****7270",
        "identity_card": "210282*********8111",
        "id_number": "210282********8111",
        "name": "萧炎",
        "invitation_card": "98******98",
        "invitation_id": 1,
        "email": "email@ybyt.ccc",
        "type": "Patient",
        "status": "Staff",
        "lamp_number": 1,
        "is_partner": true,
        "family_health_manager": false,
        "family_doctor": false,
        "health_manager": false,
        "staff_type": "R&D"
      }
      ```
      > 请求失败返回信息

      ```json
      {
        "error_message": "注册失败",
        "error_code": 401
      }
      ```
    NOTES
    params do
    end
    post 'create_user' do
    end

    desc '方案',detail: <<-NOTES.strip_heredoc
      > 请求成功返回信息

      ```json
      {
        数组格式
        {
          "identity_card": "210282199809088111",
          "coding": "YB20170112817126",
          "product": "[{\"产品名\":\"甘净\",\"产品编号\":\"1010\",\"用法\":\"3片/次、4次/天（三餐前+睡前）\",\"数量\":2},{\"产品名\":\"甘净\",\"产品编号\":\"1010\",\"用法\":\"3片/次、4次/天（三餐前+睡前）\",\"数量\":3},{\"产品名\":\"甘净\",\"产品编号\":\"1010\",\"用法\":\"3片/次、4次/天（三餐前+睡前）\",\"数量\":22}]",
          "created_at": "2017-01-12T14:17:59.000+08:00"
        }
      }
      ```
    NOTES
    params do
      requires :id_number, type: String
    end
    get 'scheme' do
      scheme = HealthProgram.where(identity_card: params[:id_number])
      present scheme,with: ::Entities::HealthProgram
    end

    desc '健康档案',detail: <<-NOTES.strip_heredoc
      > 请求成功返回信息

      ```json
      {
        "desc": "健康档案过长 这里省略数组里的其他值"
        "name": "萧炎",
        "sex": "男",
        "birthday": "19**-0*-0*",
        "marriage": "未婚",
        "id_number": "210************111",
        "nation": "汉族",
        "phone": "153****6248",
        "address": "深圳南山TCLF1",
        "occupation": "程序猿",
        "health_status": {
            "item_a": "[\"颈椎病\"]",
        },
        "family_history": {
            "father": "[]",
        },
        "drink_history": {
            "item_1": null,
        },
        "smoke_history": {
            "item_1": null,
        },
        "eating_habit": {
            "item_1": null,
        },
        "exercise_habit": {
            "item_1": null,
        },
        "sleep_habit": {
            "item_1": null,
        },
        "emotional_state": {
            "item_1": null,
        },
        "environment_state": {
            "item_1": null,
        },
        "professional_state": {
            "item_1": null,
        },
        "excretion": {
            "item_1": null,
        },
        "check_body": {
            "item_1": null,
        },
        "physical_examination": {
            "height": "",
        }
      }
      ```
    NOTES
    params do
      requires :id_number, type: Integer
    end
    get 'health_record' do
      mall = Sdk::Mall.new
      health_record = mall.record(params[:id_number])
    end

    desc 'tds数字中医',detail: <<-NOTES.strip_heredoc
      > 请求成功返回信息

      ```json
      {
        数组
        {
            "id": 1638,
            "report_url": "http://www.hsnet.cn/report/ZhongYi/ybyt/zm_report.aspx?para=010200722200606200",
            "get_jsonResult": "[{\"Name\":\"肖辉周\",\"ID_Card\":\"210282199809088111\",\"Age\":\"19\",\"Sex\":\"男\",\"Weight\":\"58kg\",\"Height\":\"175cm\",\"Blood\":\"102/53mmHg\",\"Pulse\":\"67s/m\",\"Marry\":\"未婚\",\"Native\":\"辽宁省\",\"H1\":\"59.7953\",\"H2\":\"67.0947\",\"L1\":\"45.8964\",\"L2\":\"39.3969\",\"L01\":\"(65.44)\",\"L02\":\"(66.57)\",\"L03\":\"(39.79)\",\"L04\":\"(55.26)\",\"L05\":\"(57.52)\",\"L06\":\"(76.57)\",\"L07\":\"(23.00)\",\"L08\":\"(59.41)\",\"L09\":\"(51.86)\",\"L10\":\"(74.31)\",\"L11\":\"(35.45)\",\"L12\":\"(60.73)\",\"R01\":\"(35.26)\",\"R02\":\"(74.12)\",\"R03\":\"(31.49)\",\"R04\":\"(41.68)\",\"R05\":\"(45.26)\",\"R06\":\"(63.74)\",\"R07\":\"(28.47)\",\"R08\":\"(56.95)\",\"R09\":\"(39.98)\",\"R10\":\"(84.30)\",\"R11\":\"(29.79)\",\"R12\":\"(64.69)\",\"BS\":\"BS01102128\",\"Rid\":\"R010722606\",\"Bdata\":\"2017/6/19 16:10:24\",\"M\":\"52.57\",\"Sm\":\"机体精气神的综合反映，标准值内数值愈大说明身体营养状态愈良好，机体调节适应能力愈强。\",\"Dx\":\"0.85\",\"Sdx\":\"代谢状态良好：机体代谢功能正常。\",\"My\":\"4.1\",\"Smy\":\"免疫正常：抗病能力与病后康复能力较好。\",\"XL\":\"62.48\",\"Sxl\":\"焦虑情绪：有时有情绪忧虑，较易紧张、情绪不稳定或有些心理压力。\",\"Pl\":\"20.26\",\"Spl\":\"基本正常：体力较充沛、能完成正常的工作学习任务。\",\"Js1\":\"1.40\",\"Sjs1\":\"表现为精神兴奋、焦虑、心理压力状态。\",\"Yd1\":\"1.12\",\"Syd1\":\"左右经气相对平衡，运动调适机能良好。\",\"Zw1\":\"胃寒\",\"Szw1\":\"植物神经功能失调，可能有情绪波动、睡眠不宁。\",\"Tzzs1\":\"18.94\",\"Stzzs1\":\"正常，注意保持。\",\"Zy\":\"http://www.hsnet.cn/report/ZhongYi/ybyt/tl.aspx?tid=d:\\\\www\\\\ybyt\\\\2\\\\21.txt;胃寒;http://www.hsnet.cn/report/ZhongYi/ybyt/tl.aspx?tid=d:\\\\www\\\\ybyt\\\\2\\\\27v.txt;肝火亢盛;\",\"Zy1\":null,\"Hysj\":\"胃经活跃时间7点--9点\",\"Zz\":\"温胃散寒\",\"B1\":\"呼吸道炎症;\",\"B2\":\"\",\"B3\":\"\",\"B4\":\"胃炎/溃疡倾向;\",\"B5\":\"\",\"B6\":\"颈腰椎病倾向;\",\"B7\":\"可疑血管神经性头痛;植物神经功能失调;\",\"B8\":\"可疑心脑血管供血不足;低血压倾向;\",\"B9\":\"胆囊收缩不良;\",\"B10\":\"\",\"B11\":\"结肠炎;\",\"B12\":\"\",\"B13\":\"\",\"B14\":\"----\",\"B15\":\"----\",\"B16\":\"----\",\"B17\":\"----\",\"B18\":\"----\",\"S1\":\"无\"}]",
            "created_at": "2017-06-19T16:11:03.000+08:00"
        }
      }
      ```
    NOTES
    params do
      requires :id_number, type: Integer
    end
    get 'tds_record' do
      mall = Sdk::Mall.new
      tds_record = mall.tds_report(params[:id_number])
    end

    desc '动态数据',detail: <<-NOTES.strip_heredoc
      > 请求成功返回信息

      ```json
      {
        血压数据
        {
            "id": 891,
            "created_at": "2017-06-09T16:17:35.000+08:00",
            "updated_at": "2017-06-09T16:17:35.000+08:00",
            "examine_record_id": null,
            "diastolic_pressure": 62,
            "systolic_pressure": 111,
            "phone": "15302696248",
            "state": "设备上传",
            "user_id": 2,
            "heart": null
        }
        血糖数据
        {
            "id": 459,
            "created_at": "2017-11-06T08:47:32.000+08:00",
            "updated_at": "2017-12-05T14:19:24.000+08:00",
            "examine_record_id": null,
            "phone": "15302696248",
            "state": "设备上传",
            "user_id": 2,
            "value": 10.1,
            "mens_type": 2
        }
        血脂数据
        {
            "id": 129,
            "value": 6.36,
            "phone": "15302696248",
            "state": "设备上传",
            "user_id": 2,
            "created_at": "2017-11-06T08:47:50.000+08:00",
            "updated_at": "2017-12-05T14:20:09.000+08:00"
        }
        体重数据
        {
            "id": 672,
            "value": 56.3,
            "created_at": "2017-06-09T16:18:32.000+08:00",
            "updated_at": "2017-06-09T16:18:32.000+08:00",
            "examine_record_id": null,
            "height": null,
            "phone": "15302696248",
            "state": "设备上传",
            "user_id": 2
        }
        体温数据
        {
            "id": 859,
            "value": 36.7,
            "created_at": "2017-06-09T16:18:19.000+08:00",
            "updated_at": "2017-06-09T16:18:19.000+08:00",
            "examine_record_id": null,
            "phone": "15302696248",
            "state": "设备上传",
            "user_id": 2
        }
      }
      ```

      > 编号辨识

      ```json
      {
        "# 1 血压 # 2 血糖 # 3 血脂 # 4 体重 # 5 体温"
      }
      ```
    NOTES
    params do
      requires :user_id, type: Integer
      requires :data_number, type: Integer
    end
    get 'health_data' do
      # 1 血压 # 2 血糖 # 3 血脂 # 4 体重 # 5 体温
      case params[:data_number]
      when 1
        @show = BloodPressure.where(user_id: params[:user_id])
      when 2
        @show = BloodGlucose.where(user_id: params[:user_id])
      when 3
        @show = BloodFat.where(user_id: params[:user_id])
      when 4
        @show = Weight.where(user_id: params[:user_id])
      when 5
        @show = Temperature.where(user_id: params[:user_id])
      end
    end

  end

end
