class Mall::AddressesController < Mall::BaseController
  before_action :set_address, only: [:edit, :update, :destroy]

  def index
    @addresses = current_user.addresses
  end

  def new
    @address = current_user.addresses.build
  end

  def create
    @address = current_user.addresses.new(address_params)
    if @address.save
      redirect_to mall_addresses_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @address.update(address_params)
      redirect_to mall_addresses_path
    else
      render :edit
    end
  end

  def destroy
    @address.destroy
    render nothing: true, status: :ok
  end

  private

  def set_address
    @address = current_user.addresses.find(params[:id])
  end

  def address_params
    params.require(:address).permit(:contact_name,
                                    :province,
                                    :city,
                                    :street,
                                    :mobile,
                                    :detail)
  end
end
