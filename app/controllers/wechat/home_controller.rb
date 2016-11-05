class Wechat::HomeController < Wechat::BaseController
  def index
    @slides = Slide.where(is_show: true).order(weight: :asc).limit(3)
  end
end
