class Examine::GlucoseController < Examine::BaseController

  def new
    @glucose = BloodGlucose.new
    @blood = BloodGlucose.where(user_id:current_user.user_id)
    @search = @blood.order(created_at: :desc).limit(5)
  end

  def create
    @id_number = User.where(id:current_user.user_id).take
    if !@id_number.nil?
      @glucose = BloodGlucose.new(user_id: current_user.user_id,ante_cibum:glucose_params[:ante_cibum],after_a_meal: glucose_params[:after_a_meal])
      respond_to do |format|
        if @glucose.save
          format.html { redirect_to examine_glucose_path, notice: '上传成功'}
        else
          format.html { redirect_to examine_glucose_path, notice: '上传失败'}
        end
      end
      if !@id_number.identity_card.nil?
        mall = Sdk::Mall.new
        mall.api_blood_glucose(@id_number.identity_card,glucose_params[:ante_cibum],glucose_params[:after_a_meal])
      end
    else
      redirect_to '/user/binding'
      return
    end
  end

  def glucose_params
    params.require(:blood_glucose).permit!
  end
end
