class Examine::HomeController < Examine::BaseController
  def index
    @health_examine = HealthExamine.all
  end
end
