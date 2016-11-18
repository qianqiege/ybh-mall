class Mall::OrdersController < Mall::BaseController
  include BindPhone
  before_action :check_bind_phone, only: [:confirm]
  include HasAddress
  before_action :check_has_address, only: [:confirm]

  def create
  end

  def confirm
  end
end
