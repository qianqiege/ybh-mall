class Examine::GlucoseController < Examine::BaseController
  helper_method :create_glucose

  def new
    @glucose = BloodGlucose.new
  end

  def create_glucose
    @glucose = BloodGlucose.new(glucose_params)
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
