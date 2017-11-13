class Doctor::PatientController < Wechat::BaseController
  def info
    if !params[:id].nil?
      @idcard = User.find(params[:id])
      @id = params[:id]
    else
      @idcard = User.find(current_user.user_id)
    end
    mall = Sdk::Mall.new
    @record = mall.record(@idcard.identity_card)
  end
end
