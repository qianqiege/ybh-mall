class Mall::HomeController < Mall::BaseController
  def index
    @slides = Slide.top(2)
  end
end
