require 'uri'
class User::ExamineDataController < Wechat::BaseController

  def health_data_home
  end

  def health_doctor
    @doctor_info_review = current_user.user.user_info_review
    if @doctor_info_review
      if @doctor_info_review.identity == "user"
        flash[:notice] = "请先选择角色，完善注册信息，登录健康天使。"
        redirect_to user_edit_user_info_review_path
      end
    else
      flash[:notice] = "请先选择角色，完善注册信息，登录健康天使。"
      redirect_to user_edit_user_info_review_path
    end

    @doctor = UserInfoReview.where("state = ? and identity != ?","dealed","User")
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
      if !@show.nil?
        mall = Sdk::Mall.new
        @show = mall.get_health_data(current_user.user.identity_card,6)
      end
    end
  end

  def show_temperature
    if !current_user.user_id.nil?
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
      if !@show.nil?
        mall = Sdk::Mall.new
        @show = mall.get_health_data(current_user.user.identity_card,4)
      end
    end
  end

  def show_weight
    if !current_user.user_id.nil?
      @show = Weight.where(user_id: current_user.user_id).page(params[:page] || 1).per(10).order(created_at: :desc)
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
      if !@show.nil?
        mall = Sdk::Mall.new
        @show = mall.get_health_data(current_user.user.identity_card,7)
      end
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
      if !@show.nil?
        mall = Sdk::Mall.new
        @show = mall.get_health_data(current_user.user.identity_card,2)
      end
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
      if !@show.nil?
        mall = Sdk::Mall.new
        @show = mall.get_health_data(current_user.user.identity_card,1)
      end
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
      if !@show.nil?
        mall = Sdk::Mall.new
        @show = mall.get_health_data(current_user.user.identity_card,3)
      end
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
      if !@show.nil?
        mall = Sdk::Mall.new
        @show = mall.get_health_data(current_user.user.identity_card,5)
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
