class Examine::BodyTemperatureController < Examine::BaseController
  helper_method :create_temperature

  def new
    @temperature = Temperature.new
  end

  def create_temperature
    @temperature = Temperature.new(temperature_params)
    respond_to do |format|
      if @temperature.save
        format.html { redirect_to examine_body_temperature_new_path, notice: '保存成功'}
      else
        format.html { redirect_to examine_body_temperature_new_path, notice: '保存失败'}
      end
    end
  end

  def temperature_params
    params.require(:temperature).permit!
  end
end
