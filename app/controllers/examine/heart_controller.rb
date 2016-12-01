class Examine::HeartController < Examine::BaseController

  def new
    @heart = HeartRate.new
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
  end

  def heart_params
    params.require(:heart_rate).permit!
  end
end
