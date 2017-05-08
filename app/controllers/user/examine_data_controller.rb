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
    @show = Ecg.find(params[:format]).order(created_at: :desc)
  end

end
