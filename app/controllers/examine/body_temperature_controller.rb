class Examine::BodyTemperatureController < Examine::BaseController

  def new
    @temperature = Temperature.new
    @blood = Temperature.where(user_id:current_user.user_id)
    @search = @blood.order(created_at: :desc).limit(5)
  end

  def create
    @id_number = User.find(current_user.user_id)
    if !@id_number.nil?
      @temperature = Temperature.new(user_id: current_user.user_id,value: temperature_params[:value])
      respond_to do |format|
        if @temperature.save
          format.html { redirect_to examine_temperature_path, notice: '上传成功'}
        else
          format.html { redirect_to examine_temperature_path, notice: '上传失败'}
        end
      end

      # if !@id_number.identity_card.nil?
      #   mall = Sdk::Mall.new
      #   mall.api_temperature(@id_number.identity_card,temperature_params[:value])
      # end
    else
      redirect_to '/user/binding'
      return
    end
  end

  def temperature_params
    params.require(:temperature).permit!
  end
end
