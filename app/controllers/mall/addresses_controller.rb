class Mall::AddressesController < Mall::BaseController
  def deliver
  end

  def new
    @address = current_user.addresses.build
  end

  def create
    @address = current_user.addresses.new(address_params)
    if @address.save
    else
      render :new
    end
  end

  private

  def address_params
    params.require(:address).permit(:contact_name,
                                    :province,
                                    :city,
                                    :street,
                                    :mobile,
                                    :detail)
  end
end
