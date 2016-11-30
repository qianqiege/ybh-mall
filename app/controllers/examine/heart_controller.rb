class Examine::HeartController < Examine::BaseController
  helper_method :create_heart

  def new
    @heart = HeartRate.new
  end

  def create_heart
    @heart = HeartRate.new(heart_params)
    respond_to do |format|
      if @heart.save
        format.html { redirect_to examine_heart_new_path, notice: '保存成功'}
      else
        format.html { redirect_to examine_heart_new_path, notice: '保存失败'}
      end
    end
  end

  def heart_params
    params.require(:heart_rate).permit!
  end
end
