class Doctor::InfoController < Wechat::BaseController
	skip_before_filter :verify_authenticity_token

	def doctor_info
		if params[:id].present?
			@doctor = User.find(params[:id])
			@doctor_info_review = @doctor.user_info_review
		else
			@doctor_info_review = UserInfoReview.find(params[:format])
		end

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

		@wether_show_request = current_user.user.user_info_review.identity != "user"
		@request_all = DoctorOrUser.where(doctor_id: current_user.user_id)
		@request_pending = DoctorOrUser.where(state: "pending",doctor_id: current_user.user_id)
		@request_dealed = DoctorOrUser.where("state != ? and doctor_id = ?", "pending", current_user.user_id)
	end

	def user_request_deal
		request = DoctorOrUser.find(params[:id])
		if params[:type] == "1"
			request.pass
		else
			request.not_pass
		end
		redirect_to :back
	end
end











