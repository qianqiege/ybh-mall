class Wechat::HomeController < Wechat::BaseController
  def index
    @slides = Slide.top(1)
    @setmeal = Setmeal.all
    @type = VipType.includes(:member_clubs)
  end

  def merchants
    @file_assets = FileAsset.all
  end
end
