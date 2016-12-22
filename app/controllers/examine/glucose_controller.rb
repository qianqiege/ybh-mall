class Examine::GlucoseController < Examine::BaseController

  def new
    @glucose = BloodGlucose.new
    @blood = BloodGlucose.where(wechat_user_id:current_user.id)
    @search = @blood.order(created_at: :desc).limit(5)
  end

  def create
    @glucose = current_user.blood_glucoses.build(glucose_params)
    respond_to do |format|
      if @glucose.save
        format.html { redirect_to examine_glucose_path, notice: '上传成功'}
      else
        format.html { redirect_to examine_glucose_path, notice: '上传失败'}
      end
    end
    @id_number = User.where(id:current_user.user_id).take
    if !@id_number.identity_card.nil?
      mall = Sdk::Mall.new
      mall.api_blood_glucose(@id_number.identity_card,glucose_params[:ante_cibum],glucose_params[:after_a_meal])
    end
  end

  def glucose_params
    params.require(:blood_glucose).permit!
  end
end