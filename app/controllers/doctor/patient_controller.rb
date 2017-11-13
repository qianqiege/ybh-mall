class Doctor::PatientController < Wechat::BaseController
  def info
    if !params[:format].nil?
      @idcard = User.find(params[:format])
    else
      @idcard = User.find(current_user.user_id)
    end
    mall = Sdk::Mall.new
    @record = mall.record(@idcard.identity_card)
  end
end
