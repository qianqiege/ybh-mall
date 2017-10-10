class Doctor::InfoController < Wechat::BaseController
	skip_before_filter :verify_authenticity_token

	def doctor_info
		@doctor = User.find(params[:id])
		@doctor_info_review = @doctor.user_info_review
		if @doctor_info_review.identity == "user" 
			flash[:notice] = "没有权限访问该板块!"
			redirect_to :back
		end
	end
end