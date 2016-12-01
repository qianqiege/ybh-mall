class Examine::GlucoseController < Examine::BaseController

  def new
    @glucose = BloodGlucose.new
  end

  def create
    @glucose = current_user.temperatures.build(glucose_params)
    respond_to do |format|
      if @glucose.save
        format.html { redirect_to examine_glucose_new_path, notice: '保存成功'}
      else
        format.html { redirect_to examine_glucose_new_path, notice: '保存失败'}
      end
    end
  end

  def glucose_params
    params.require(:blood_glucose).permit!
  end
end
