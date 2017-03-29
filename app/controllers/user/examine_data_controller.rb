class User::ExamineDataController < Wechat::BaseController

  def health_data_home
  end

  def show_blood_fat
    if !current_user.user_id.nil?
      @show = BloodFat.where(user_id: current_user.user_id)
    end
  end

  def show_temperature
    if !current_user.user_id.nil?
      @show = Temperature.where(user_id: current_user.user_id)
    end
  end

  def show_weight
    if !current_user.user_id.nil?
      @show = Weight.where(user_id: current_user.user_id)
    end
  end

  def show_glucose
    if !current_user.user_id.nil?
      @show = BloodGlucose.where(user_id: current_user.user_id)
    end
  end

  def show_heart
    if !current_user.user_id.nil?
      @show = HeartRate.where(user_id: current_user.user_id)
    end
  end

  def show_pressure
    if !current_user.user_id.nil?
      @show = BloodPressure.where(user_id: current_user.user_id)
      # @systolic_pressure = []
      # @diastolic_pressure = []
      # i = 0
      # @show.each do |show|
      #   @systolic_pressure[i] = show.systolic_pressure
      #   @diastolic_pressure[i] = show.diastolic_pressure
      #   i =i + 1
      # end
      # ap @systolic_pressure
      # ap @diastolic_pressure
    end
  end

  def show_unine

  end

end
