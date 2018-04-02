class SaleProduct < ApplicationRecord
  SALE_TYPE = {'0' => "左店购买产品", '1' => "右店领配产品"}

  belongs_to :product
  belongs_to :parallel_shop
  def sale_type_name
    SALE_TYPE[self.sale_type.to_s]
  end

end
