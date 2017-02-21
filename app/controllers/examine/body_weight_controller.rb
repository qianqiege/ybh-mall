class Examine::BodyWeightController < Examine::BaseController

  def new
    @weight = Weight.new
    @blood = Weight.where(user_id:current_user.user_id)
    @search = @blood.order(created_at: :desc).limit(5)
  end

  def create
    @id_number = User.where(id:current_user.user_id).take
    if !@id_number.nil?
      @weight = Weight.new(user_id: current_user.user_id,value: weight_params[:value],height: weight_params[:height])
      respond_to do |format|
        if @weight.save
          format.html { redirect_to examine_weight_path, notice: '上传成功'}
        else
          format.html { redirect_to examine_weight_path, notice: '上传失败'}
        end
      end

      if !@id_number.identity_card.nil?
        mall = Sdk::Mall.new
        mall.api_weight(@id_number.identity_card,weight_params[:value],weight_params[:height])
      end
    else
      redirect_to '/user/binding'
      return
    end
  end

  def weight_params
    params.require(:weight).permit!
  end
end
