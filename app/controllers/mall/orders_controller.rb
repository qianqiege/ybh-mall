class Mall::OrdersController < Mall::BaseController
  include BindPhone
  before_action :check_bind_phone, only: [:create]

  def create
  end
end
