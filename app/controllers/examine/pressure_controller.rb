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
        format.html { redirect_to examine_pressure_path, notice: '上传成功'}
      else
        format.html { redirect_to examine_pressure_path, notice: '上传失败'}
      end
    end
    @id_number = User.where(id:current_user.user_id).take
    if !@id_number.identity_card.nil?
      mall = Sdk::Mall.new
      mall.api_blood_pressure(@id_number.identity_card,pressure_params[:diastolic_pressure],pressure_params[:systolic_pressure])
    end
  end

  def pressure_params
    params.require(:blood_pressure).permit!
  end
end