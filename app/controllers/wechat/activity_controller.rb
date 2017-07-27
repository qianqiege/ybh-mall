class Wechat::ActivityController < Wechat::BaseController
  def index
   @activity = Activity.where(is_show: true)
  end
end
