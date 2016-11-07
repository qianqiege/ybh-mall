class Wechat::GoodsController < Wechat::BaseController
  def index
    @slides = Slide.where(is_show: true).order(weight: :asc).limit(3)
  end
  def classify

  end
  def shopping_car

  end
end
