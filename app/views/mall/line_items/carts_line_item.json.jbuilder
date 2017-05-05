if @line_item.errors.any?
  json.error_messages @line_item.errors.messages.values.join(', ')
  # 处理当库存数量不足时的情况
  if @line_item.quantity > @line_item.product.shop_count
    if @action == "add"
      json.price -(@line_item.price * (@line_item.reload.quantity - @line_item.product.shop_count))
    elsif @action == "remove"
      json.price @line_item.price * (@line_item.reload.quantity - @line_item.product.shop_count)
    end
  end
else
  # 商品价格，购物车页面中增加减少商品使用
  # @line_item.price 为商品单价，@quantity为数量
  json.price money(@line_item.price * @quantity)
  # 商品总价格
  json.current_line_item_price money @line_item.total_price
end

json.action @action

# 购物车页面中增加减少商品使用
if @action == 'add' || @action == 'remove'
  json.quantity @line_item.reload.real_quantity
end

# 商品展示页面中显示购物车的数目
json.cart_real_product_count current_cart.real_product_count

json.fast_buy params[:fast_buy] if params[:fast_buy]
