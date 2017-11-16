class Doctor::HomeController < Wechat::BaseController
  def index
  	  if !current_user.user.user_info_review
  	  	p "@"*30
  	  	redirect_to :back, notice: "只有健康管理师才能访问该模板的权限!"
  	  else
	  	  if current_user.user.user_info_review.identity == "user"
	  	  	redirect_to :back, notice: "只有健康管理师才能访问该模板的权限!"
	  	  end
	      @slides = Slide.top(1)
	      @user_info_review = UserInfoReview.where(identity: 'family_doctor',
	      identity: 'family_health_manager',identity: 'helath_manager').order(ranking: :desc).limit(10)
	     end
    end

end
