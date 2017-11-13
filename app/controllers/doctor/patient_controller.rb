class Doctor::PatientController < Wechat::BaseController
  def info
    if !params[:id].present?
      @doctor_info_review = current_user
    else
      @doctor_info_review = UserInfoReview.find(params[:format])
    end
  end
end
