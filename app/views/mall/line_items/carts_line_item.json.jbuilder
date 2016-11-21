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
  json.price money @line_item.price
  json.current_line_item_price money @line_item.real_total_price
end

json.action @action

unless @action == 'delete'
  json.quantity @line_item.reload.real_quantity
end

json.cart_real_product_count current_cart.real_product_count
