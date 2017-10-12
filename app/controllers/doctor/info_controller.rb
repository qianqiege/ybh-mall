class Doctor::InfoController < Wechat::BaseController
	skip_before_filter :verify_authenticity_token

	def doctor_info
		@doctor = User.find(params[:id])
		@doctor_info_review = @doctor.user_info_review
		p "@"*40
		p @doctor_info_review.inspect
		if @doctor_info_review
			if @doctor_info_review.identity == "user" 
				flash[:notice] = "请先选择角色，完善注册信息，登录健康天使。"
				redirect_to user_edit_user_info_review_path
			end
		else
			flash[:notice] = "请先选择角色，完善注册信息，登录健康天使。"
			redirect_to user_edit_user_info_review_path
		end
	end
end