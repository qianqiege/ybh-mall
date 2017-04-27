class Wechat::DirectSeedingController < Wechat::BaseController
  def home
    @slides = Slide.top(1)
  end
end
