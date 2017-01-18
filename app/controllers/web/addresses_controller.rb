class Web::AddressesController < Web::BaseController
  def new
    @address = current_user.addresses.new
  end

  def create
    @address = current_user.addresses.new(address_params)
    if @address.save
      flash[:success] = '收货地址创建成功'
      redirect_to '/web/orders/confirm'
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
