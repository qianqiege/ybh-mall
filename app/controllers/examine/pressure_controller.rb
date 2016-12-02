class Examine::PressureController < Examine::BaseController

  def new
    @pressure = BloodPressure.new
    @blood = BloodPressure.where(wechat_user_id:current_user.id)
    @search = @blood.order(created_at: :desc).limit(5)
  end

  def create
    @pressure = current_user.blood_pressures.build(pressure_params)
    respond_to do |format|
      if @pressure.save
        format.html { redirect_to examine_pressure_path, notice: '保存成功'}
      else
        format.html { redirect_to examine_pressure_path, notice: '保存失败'}
      end
    end
  end

  def pressure_params
    params.require(:blood_pressure).permit!
  end
end
