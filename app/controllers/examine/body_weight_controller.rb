class Examine::BodyWeightController < Examine::BaseController
  helper_method :create_weight

  def new
    @weight = Weight.new
  end

  def create_weight
    @weight = BloodGlucose.new(weight_params)
    respond_to do |format|
      if @weight.save
        format.html { redirect_to examine_body_weight_new_path, notice: '保存成功'}
      else
        format.html { redirect_to examine_body_weight_new_path, notice: '保存失败'}
      end
    end
  end

  def weight_params
    params.require(:weight).permit!
  end
end
