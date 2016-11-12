class Serve::HomeController < Wechat::BaseController
  def index
    @slides = Slide.top(3)
    @serves = Serve.all
  end
  def show

  end
end
