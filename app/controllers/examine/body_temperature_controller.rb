class Examine::BodyTemperatureController < Examine::BaseController

  def new
    @temperature = Temperature.new
    @blood = Temperature.where(wechat_user_id:current_user.id)
    @search = @blood.order(created_at: :desc).limit(5)
  end

  def create
    @temperature = current_user.temperatures.build(temperature_params)
    respond_to do |format|
      if @temperature.save
        format.html { redirect_to examine_temperature_path, notice: '保存成功'}
      else
        format.html { redirect_to examine_temperature_path, notice: '保存失败'}
      end
    end
  end

  def temperature_params
    params.require(:temperature).permit!
  end
end
