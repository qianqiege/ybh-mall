class Examine::BloodFatController < Examine::BaseController
  def new
    @blood_fat = BloodFat.new
    @show_unine = BloodFat.where(user_id: current_user.user_id)
    @search = @show_unine.order(created_at: :desc).limit(5)
  end

  def create
    @id_number = User.where(id:current_user.user_id).take
    if !@id_number.nil?
      @blood_fat = BloodFat.new(user_id: current_user.user_id,value: fat_params[:value])
      respond_to do |format|
        if @blood_fat.save
          format.html { redirect_to examine_fat_path, notice: '上传成功'}
        else
          format.html { redirect_to examine_fat_path, notice: '上传失败'}
        end
      end
      # if !@id_number.identity_card.nil?
      #   mall = Sdk::Mall.new
      #   mall.api_blood_glucose(@id_number.identity_card,glucose_params[:value],glucose_params[:mens_type])
      # end
    else
      redirect_to '/user/binding'
      return
    end
  end

  def fat_params
    params.require(:blood_fat).permit!
  end
end
