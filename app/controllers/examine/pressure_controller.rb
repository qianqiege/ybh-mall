class Examine::PressureController < Examine::BaseController

  def new
    @pressure = BloodPressure.new
  end

  def create
    @pressure = current_user.temperatures.build(pressure_params)
    respond_to do |format|
      if @pressure.save
        format.html { redirect_to examine_pressure_new_path, notice: '保存成功'}
      else
        format.html { redirect_to examine_pressure_new_path, notice: '保存失败'}
      end
    end
  end

  def pressure_params
    params.require(:blood_pressure).permit!
  end
end
