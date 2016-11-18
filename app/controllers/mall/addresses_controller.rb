class Mall::AddressesController < Mall::BaseController
  before_action :set_address, only: [:edit, :update, :destroy, :make_default]

  def index
    @addresses = current_user.addresses
  end

  def new
    @address = current_user.addresses.build
  end

  def create
    @address = current_user.addresses.new(address_params)
    if @address.save
      flash[:success] = '创建成功'
      redirect_to mall_addresses_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @address.update(address_params)
      flash[:success] = '修改成功'
      redirect_to mall_addresses_path
    else
      render :edit
    end
  end

  def destroy
    flash[:success] = '删除成功'
    @address.destroy
    render nothing: true, status: :ok
  end

  def make_default
    addresses = current_user.addresses
    addresses.update_all is_default: false
    @address.update_attribute(:is_default, true)
    flash[:success] = '设置成功'
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
