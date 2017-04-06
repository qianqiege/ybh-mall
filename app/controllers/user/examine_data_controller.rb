class User::ExamineDataController < Wechat::BaseController

  def health_data_home
  end

  def show_blood_fat
    if !current_user.user_id.nil?
      @show = BloodFat.where(user_id: current_user.user_id)
      @options = {
        colors: ["#ff0000", "#add9c0"],
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
      @show = Temperature.where(user_id: current_user.user_id)
      @options = {
        colors: ["#ff0000", "#add9c0"],
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
      @show = Weight.where(user_id: current_user.user_id)
      @options = {
        colors: ["#ff0000", "#add9c0"],
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
      @show = BloodGlucose.where(user_id: current_user.user_id)
      @options = {
        colors: ["#ff0000", "#add9c0"],
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
      @show = HeartRate.where(user_id: current_user.user_id)
      @options = {
        colors: ["#ff0000", "#add9c0"],
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
      @show = BloodPressure.where(user_id: current_user.user_id).order(updated_at: :desc)
      @options = {
        colors: ["#ff0000", "#add9c0"],
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
      @show = Unine.where(user_id: current_user.user_id).order(updated_at: :desc)
      @options = {
        colors: ["#ff0000", "#add9c0"],
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

end
