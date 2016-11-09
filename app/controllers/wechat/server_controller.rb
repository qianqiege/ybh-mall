class Wechat::ServerController < Wechat::BaseController
  def index
    @slides = Slide.where(is_show: true).order(weight: :asc).limit(3)
    @serve = Serve.all
  end

  def show
    
  end
end
