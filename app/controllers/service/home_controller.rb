class Service::HomeController < Service::BaseController
  def index
    @slides = Slide.top(3)
    @serves = Serve.all
  end
end
