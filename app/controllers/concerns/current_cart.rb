module CurrentCart
  extend ActiveSupport::Concern

  private

  def set_cart
    unless current_cart
      current_user.create_cart
    end
  end

  def check_cart
    # 检查购物车商品数量是否超出商品库存
    # 商品库存会随时变化，可以跟前一时间放入购物车的商品数量有区别
    # 购物车的商品数量比实际能购买的大
    if current_cart && (current_cart.product_count > current_cart.real_product_count)
      current_cart.line_items.each do |line_item|
        line_item.update_attribute(:quantity, line_item.real_quantity)
      end
      flash.now[:notice] = '购物车的商品库存不足，系统自动改为最大购买数目'
    end
  end
end
