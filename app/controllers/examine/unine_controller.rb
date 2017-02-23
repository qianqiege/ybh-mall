class Examine::UnineController < Examine::BaseController
  def new
    @unine = Unine.new
    @show_unine = Unine.where(user_id: current_user.user_id)
    @search = @show_unine.order(created_at: :desc).limit(5)
  end

  def create
    @id_number = User.where(id:current_user.user_id).take
    if !@id_number.nil?
      @unine = Unine.new(user_id: current_user.user_id,value: unine_params[:value])
      respond_to do |format|
        if @unine.save
          format.html { redirect_to examine_unine_path, notice: '上传成功'}
        else
          format.html { redirect_to examine_unine_path, notice: '上传失败'}
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

  def unine_params
    params.require(:unine).permit!
  end
end
