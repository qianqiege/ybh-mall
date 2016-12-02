class Examine::BodyWeightController < Examine::BaseController

  def new
    @weight = Weight.new
    @blood = Weight.where(wechat_user_id:current_user.id)
    @search = @blood.order(created_at: :desc).limit(5)
  end

  def create
    @weight = current_user.weights.build(weight_params)
    respond_to do |format|
      if @weight.save
        format.html { redirect_to examine_weight_path, notice: '保存成功'}
      else
        format.html { redirect_to examine_weight_path, notice: '保存失败'}
      end
    end
  end

  def weight_params
    params.require(:weight).permit!
  end
end
