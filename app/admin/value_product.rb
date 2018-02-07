ActiveAdmin.register ValueProduct do
  menu parent: I18n.t("active_admin.menu.mall")

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :name, 
  				:contents_category_id, 
				:image,
				:price,
				:product_number,
				:inventory,
				:spec,
				:desc,
				:is_show,
				:create_at,
				:update_at
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
  	column :name
	column :contents_category_id 
	column :image
	column :price
	column :product_number
	column :inventory
	column :spec
	column :desc
	column :is_show
	column :create_at
	column :update_at
  end


end
