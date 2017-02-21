class Examine::HeartController < Examine::BaseController

  def new
    @heart = HeartRate.new
    @blood = HeartRate.where(user_id:current_user.user_id)
    @search = @blood.order(created_at: :desc).limit(5)
  end

  def create
    @id_number = User.where(id:current_user.user_id).take
    if !@id_number.nil?
      @heart = HeartRate.new(user_id: current_user.user_id,value: heart_params[:value])
      respond_to do |format|
        if @heart.save
          format.html { redirect_to examine_heart_path, notice: '上传成功'}
        else
          format.html { redirect_to examine_heart_path, notice: '上传失败'}
        end
      end
      if !@id_number.identity_card.nil?
        mall = Sdk::Mall.new
        mall.api_heart_rate(@id_number.identity_card,heart_params[:value])
      end
    else
      redirect_to '/user/binding'
      return
    end
  end

  def heart_params
    params.require(:heart_rate).permit!
  end
end
