class Mall::MyController < Mall::BaseController
  include BindPhone
  before_action :check_bind_phone, only: [:home]

  def home
  end
end
