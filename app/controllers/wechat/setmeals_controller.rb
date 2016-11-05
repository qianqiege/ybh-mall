class Wechat::SetmealsController < Wechat::BaseController
  before_action :set_setmeal, only: [:show]

  def show
  end

  private
  def set_setmeal
    @setmeal = Setmeal.find(params[:id])
  end

end
