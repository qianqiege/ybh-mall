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

    @id_number = VipRecord.where(user_id: User.where(id: WechatUser.where(id: current_user.id ))).take
    mall = Sdk::Mall.new
    mall.examination_input(@id_number.identity_card,heart_params[:value])
  end

  def api_create
  end

  def heart_params
    params.require(:heart_rate).permit!
  end
end
