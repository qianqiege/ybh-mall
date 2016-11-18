class Mall::OrdersController < Mall::BaseController
  include BindPhone
  before_action :check_bind_phone, only: [:create]
  include HasAddress
  before_action :check_has_address, only: [:create]

  def create
  end
end
