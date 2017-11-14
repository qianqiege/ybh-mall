require 'uri'
class User::ExamineDataController < Wechat::BaseController

  def health_data_home
  end

  def health_doctor
    @doctor = UserInfoReview.where("state = ? and identity != ?","dealed","User")
  end

  def show_blood_fat
    # 医生查看病人动态健康数据情况
    user = nil
    if params[:format].present?
      user = User.find(params[:format])
    end

    if !current_user.user_id.nil?
      user = current_user.user if !user.present?
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
      if !@show.nil?
        mall = Sdk::Mall.new
        @show = mall.get_health_data(current_user.user.identity_card,6)[0...10]
        @aa = []
        @show.each do |f|
            bb = [] 
            bb.push(f["updated_at"]) 
            bb.push(f["value"].to_f) 
            @aa.push(bb) 
        end
      end
    end
  end

  def show_temperature
    # 医生查看病人动态健康数据情况
    user = nil
    if params[:format].present?
      user = User.find(params[:format])
    end

    if !current_user.user_id.nil?
      user = current_user.user if !user.present?
      @show = Temperature.where(user_id: current_user.user_id).page(params[:page] || 1).per(10).order(created_at: :desc)
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
      if @show.nil?
        mall = Sdk::Mall.new
        @show = mall.get_health_data(current_user.user.identity_card,4)[0...10]
        @aa = []
        @show.each do |f|
            bb = [] 
            bb.push(f["updated_at"]) 
            bb.push(f["value"].to_f) 
            @aa.push(bb) 
        end
      end
    end
  end

  def show_weight

    # 医生查看病人动态健康数据情况
    user = nil
    if params[:format].present?
      user = User.find(params[:format])
    end

    if !current_user.user_id.nil?
      user = current_user.user if !user.present?
      @show = Weight.where(user_id: user.id).page(params[:page] || 1).per(10).order(created_at: :desc)
      @show_last = @show.last
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
      if @show.nil?
        mall = Sdk::Mall.new
        @show = mall.get_health_data(user.identity_card,7)[0...10]
        @aa = []
        @show.each do |f|
            bb = [] 
            bb.push(f["updated_at"]) 
            bb.push(f["value"]) 
            @aa.push(bb) 
        end
      end


    end
  end

  def show_glucose
    # 医生查看病人动态健康数据情况
    user = nil
    if params[:format].present?
      user = User.find(params[:format])
    end

    if !current_user.user_id.nil?
      user = current_user.user if !user.present?
      @show = BloodGlucose.where(user_id: user.id).order(created_at: :desc).limit(10)
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
      if @show.nil?
        mall = Sdk::Mall.new
        @show = mall.get_health_data(user.identity_card,2)[0...10]
        @aa = []
        @show.each do |f|
            bb = [] 
            bb.push(f["updated_at"]) 
            bb.push(f["value"].to_f) 
            @aa.push(bb) 
        end
      end
    end
  end

  def show_heart
      

      # 医生查看病人动态健康数据情况
      user = nil
      if params[:format].present?
        user = User.find(params[:format])
      end

      if !current_user.user_id.nil?
        user = current_user.user if !user.present?
        @show = HeartRate.where(user_id: user.id).order(created_at: :desc).limit(10)
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
        if @show.nil?
          mall = Sdk::Mall.new
          @show = mall.get_health_data(user.identity_card,1)[0...10]
          @aa = []
          @show.each do |f|
              bb = [] 
              bb.push(f["updated_at"]) 
              bb.push(f["value"].to_f) 
              @aa.push(bb) 
          end
        end
      end
      
  end

  def show_pressure
    # 医生查看病人动态健康数据情况
    user = nil
    if params[:format].present?
      user = User.find(params[:format])
    end

    if !current_user.user_id.nil?
      user = current_user.user if !user.present?
      @show = BloodPressure.where(user_id: user.id).order(updated_at: :desc).limit(10)
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
      if @show.nil?
        mall = Sdk::Mall.new
        @show = mall.get_health_data(user.identity_card,3)[0...10]
        @aa = []
        @cc = []
        @show.each do |f|
            bb = [] 
            dd = []
            bb.push(f["updated_at"]) 
            dd.push(f["updated_at"])
            bb.push(f["max_blood_pressure"]) 
            dd.push(f["min_blood_pressure"])
            @aa.push(bb)  
            @cc.push(dd)
        end
      end
    end
  end

  def show_unine
    # 医生查看病人动态健康数据情况
    user = nil
    if params[:format].present?
      user = User.find(params[:format])
    end

    if !current_user.user_id.nil?
      user = current_user.user if !user.present?
      @show = Unine.where(user_id: user.id).order(updated_at: :desc).limit(10)
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
      if @show.nil?
        mall = Sdk::Mall.new
        @show = mall.get_health_data(user.identity_card, 5)[0...10]
        byebug
        @aa = []
          @show.each do |f|
              bb = [] 
              bb.push(f["updated_at"]) 
              bb.push(f["value"].to_f) 
              @aa.push(bb) 
          end
      end
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
  def show_idata_subscribe
    @slides = Slide.top(7)
  end

  #数动力服务现金付款(数动力注册)
  def create_idata_subscribe

    #用户在数动力端注册
    idata_member_register


    #创建数动力用户订阅表
    # if UserIdataSubscribe.find_by(user_id: current_user.user_id).blank?
    #   UserIdataSubscribe.create(list: params[:number].split(","), user_id: current_user.user_id)
    # else
    #   UserIdataSubscribe.find_by(user_id: current_user.user_id).update(list: params[:number].split(","), status: "fail")
    # end

    Rails.logger.info "@"*20
    Rails.logger.info "create_idata_subscribe"
    Rails.logger.info params[:number].split(",")

    UserIdataSubscribeList.create(list: params[:number])

    format_data = {
      price: params[:money].to_f,
      payment: params[:payment]
    }
    @idata_subscribe = User.find(current_user.user_id).idata_subscribes.new(format_data)
    if @idata_subscribe.save
      #重定向到数动力服务支付确认界面
      redirect_to user_idata_subscribe_pay_path(@idata_subscribe)
    end
  end

  #数动力服务支付确认界面
  def idata_subscribe_pay
    @no_fotter = true
    @idata_subscribe = User.find(current_user.user_id).idata_subscribes.find(params[:format])
    @trade_merge_pay_params = @idata_subscribe.fast_pay.trade_merge_pay_params_idata_subscribe(@idata_subscribe.payment)
  end

  #显示用户在数动力服务订阅的列表
  def show_user_idata_subscribe_list
      @user_idata_subscribe = UserIdataSubscribe.find_by(user_id: current_user.user_id)
  end


  #数动力用户注册
  def idata_member_register
    result = WechatUser.find_by(user_id: current_user.user_id).idata.member_register
    Rails.logger.info "@"*20
    Rails.logger.info "用户在数动力端注册"
    Rails.logger.info result
    if (result['code'] != '0000')
      raise Exception.new(result)
    end
  end


  #用于显示周报或月报，健康悦享版，健康西游等详情
  def show_week_or_month_report
    @idata_record = IdataRecord.find_by(id: params[:id])
    @message = URI.decode(@idata_record.message)
    @message = @message.gsub(/[\+]+/, " ")
  end

end
