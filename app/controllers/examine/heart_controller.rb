class Examine::HeartController < Examine::BaseController

  def new
    @heart = HeartRate.new
    @blood = HeartRate.where(wechat_user_id:current_user.id)
    @search = @blood.order(created_at: :desc).limit(5)
  end

  def create
    @heart = current_user.heart_rates.build(heart_params)
    respond_to do |format|
      if @heart.save
        format.html { redirect_to examine_heart_path, notice: '保存成功'}
      else
        format.html { redirect_to examine_heart_path, notice: '保存失败'}
      end
    end

    @id_number = User.where(id:current_user.user_id).take
    if !@id_number.identity_card.nil?
      mall = Sdk::Mall.new
      mall.api_heart_rate(@id_number.identity_card,heart_params[:value])
    end
  end

  def heart_params
    params.require(:heart_rate).permit!
  end
end
