class Examine::BodyWeightController < Examine::BaseController

  def new
    @weight = Weight.new
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
