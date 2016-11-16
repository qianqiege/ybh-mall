class Serve::BuildspineController < Wechat::BaseController
  def index
  end

  def reservation
    @servicestaff = ServiceStaff.all
  end
end
