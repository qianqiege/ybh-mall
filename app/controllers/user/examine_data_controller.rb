class User::ExamineDataController < Wechat::BaseController

  def health_data_home
  end

  def show_blood_fat
    if !current_user.user_id.nil?
      @show = BloodFat.where(user_id: current_user.user_id).order(created_at: :desc).limit(10)
      @options = {
        colors: ["#00CD00", "#1E90FF"],
        xAxis: {
          type: 'datetime',
          labels: {
            format: '{value:%m-%d}',
            align: 'right'
          }
        }
      }
    end
  end

  def show_temperature
    if !current_user.user_id.nil?
      @show = Temperature.where(user_id: current_user.user_id).order(created_at: :desc).limit(10)
      @options = {
        colors: ["#00CD00", "#1E90FF"],
        xAxis: {
          type: 'datetime',
          labels: {
            format: '{value:%m-%d}',
            align: 'right'
          }
        }
      }
    end
  end

  def show_weight
    if !current_user.user_id.nil?
      @show = Weight.where(user_id: current_user.user_id).order(created_at: :desc).limit(10)
      @options = {
        colors: ["#00CD00", "#1E90FF"],
        xAxis: {
          type: 'datetime',
          labels: {
            format: '{value:%m-%d}',
            align: 'right'
          }
        }
      }
    end
  end

  def show_glucose
    if !current_user.user_id.nil?
      @show = BloodGlucose.where(user_id: current_user.user_id).order(created_at: :desc).limit(10)
      @options = {
        colors: ["#00CD00", "#1E90FF"],
        xAxis: {
          type: 'datetime',
          labels: {
            format: '{value:%m-%d}',
            align: 'right'
          }
        }
      }
    end
  end

  def show_heart
    if !current_user.user_id.nil?
      @show = HeartRate.where(user_id: current_user.user_id).order(created_at: :desc).limit(10)
      @options = {
        colors: ["#00CD00", "#1E90FF"],
        xAxis: {
          type: 'datetime',
          labels: {
            format: '{value:%m-%d}',
            align: 'left'
          }
        }
      }
    end
  end

  def show_pressure
    if !current_user.user_id.nil?
      @show = BloodPressure.where(user_id: current_user.user_id).order(updated_at: :desc).limit(10)
      @options = {
        colors: ["#00CD00", "#1E90FF"],
        xAxis: {
          type: 'datetime',
          labels: {
            format: '{value:%m-%d}',
            align: 'right'
          }
        }
      }
    end
  end

  def show_unine
    if !current_user.user_id.nil?
      @show = Unine.where(user_id: current_user.user_id).order(updated_at: :desc).limit(10)
      @options = {
        colors: ["#00CD00", "#1E90FF"],
        xAxis: {
          type: 'datetime',
          labels: {
            format: '{value:%m-%d}',
            align: 'right'
          }
        }
      }
    end
  end

  def show_ecg
    if !current_user.user_id.nil?
      @show = Ecg.where(user_id: current_user.user_id).order(created_at: :desc).limit(10)
    end
  end

  def ecg_image
    @show = Ecg.find(params[:format])
  end

  #显示数动力服务订阅页面
  def show_idata_subscirbe
    
  end

  #数动力服务现金付款(数动力注册)
  def create_idata_subscribe

    #用户在数动力端注册
    idata_member_register

    #创建用户数动力的订阅详情
    params[:number].split(",").each do |id|
      idata_active_service(id)
    end

    flash[:notice] = "订阅成功" 

    redirect_to user_show_idata_path


    # format_data = {
    #   price: params[:price].to_f,
    #   payment: params[:payment]
    # }
    # @idata_subscribe = User.find(current_user.user_id).idata_subscribes.new(format_data)
    # if @idata_subscribe.save
    #   #重定向到数动力服务支付确认界面
    #   redirect_to user_deposit_pay_path(@idata_subscribe)
    # end
  end

  #数动力服务支付确认界面
  def idata_subscribe_pay
    @no_fotter = true
    @idata_subscribe = User.find(current_user.user_id).idata_subscribes.find(params[:format])
    @trade_merge_pay_params = @idata_subscribe.fast_pay.trade_merge_pay_params_idata_subscribe(@idata_subscribe.payment)
  end


  #用户注册
  def idata_member_register
    result = WechatUser.find_by(user_id: current_user.user_id).idata.member_register
    puts "@"*20
    puts "用户在数动力端注册"
    puts result
    if (result['code'] != '0000')
      raise Exception.new(result)
    end
  end

  #用户订阅
  def idata_active_service(service_id)
    result = WechatUser.find_by(user_id: current_user.user_id).idata.member_register(service_id)
    puts "@"*20
    puts "用户订阅"
    puts result
    if (result['code'] != '0000')
      raise Exception.new(result)
    end
  end

end
