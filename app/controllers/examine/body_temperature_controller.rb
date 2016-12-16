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
    @id_number = User.where(id:current_user.user_id).take
    if !@id_number.identity_card.nil?
      mall = Sdk::Mall.new
      mall.api_temperature(@id_number.identity_card,temperature_params[:value])
    end
  end

  def temperature_params
    params.require(:temperature).permit!
  end
end
