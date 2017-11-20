class Doctor::HomeController < Wechat::BaseController
  def index
  	user_info_review = current_user.user.user_info_review
  	  if !user_info_review
  	  	redirect_to user_authentication_path, notice: "请先完成健康管理师的注册验证!"
  	  else
	  	  if user_info_review.identity == "user"
	  	  	redirect_to user_authentication_path, notice: "请先完成健康管理师的注册验证!"
	  	  else
	  	  	  case user_info_review.state
		  	  when "pending"
		  	  	redirect_to :back, notice: "您的信息正在审核中，请稍后访问该板块!"
		  	  when "dealing"
		  	  	redirect_to :back, notice: "您的信息正在审核中，请稍后访问该板块!"
		  	  when "not"
		  	  	redirect_to :back, notice: "您的信息审核未通过，" + user_info_review.desc + " ,请重新申请!"
		  	  end
	  	  end
	      @slides = Slide.top(1)
	      @user_info_review = UserInfoReview.where(identity: 'family_doctor',
	      identity: 'family_health_manager',identity: 'helath_manager').order(ranking: :desc).limit(10)
	     end
    end

end
