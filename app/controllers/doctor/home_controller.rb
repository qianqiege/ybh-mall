class Doctor::HomeController < Wechat::BaseController
  def index
      @slides = Slide.top(1)
      @user_info_review = UserInfoReview.where(identity: 'family_doctor',
      identity: 'family_health_manager',identity: 'helath_manager').order(ranking: :desc).limit(10)
  end
end
