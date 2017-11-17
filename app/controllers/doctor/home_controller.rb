class Doctor::HomeController < Wechat::BaseController
  def index
  	  if !current_user.user.user_info_review
  	  	redirect_to user_authentication_path, notice: "请先完成健康管理师的注册验证!"
  	  else
	  	  if current_user.user.user_info_review.identity == "user"
	  	  	redirect_to user_authentication_path, notice: "请先完成健康管理师的注册验证!"
	  	  end
	      @slides = Slide.top(1)
	      @user_info_review = UserInfoReview.where(identity: 'family_doctor',
	      identity: 'family_health_manager',identity: 'helath_manager').order(ranking: :desc).limit(10)
	     end
    end

end
