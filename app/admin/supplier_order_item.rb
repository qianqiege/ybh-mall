ActiveAdmin.register SupplierOrderItem do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :supplier_order_id, :product_id, :order_count, :prices, :amount, :discount, :receive_count
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  index do
    selectable_column
    id_column
    column :supplier_order do |su|
      su.supplier_order.try(:order_number)
    end
    column :product_id
    column :count
    column :purchase_prices
    column :amount
    column :discount
    column :receive_count
    column :created_at
    actions
  end

end
