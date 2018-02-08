ActiveAdmin.register ValueableProduct do
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
		column "商品图片" do |slide|
      # image_tag(slide.image, size: "72x45", :alt => "product image")
    end
		column :name
		column :contents_category_id 
		column :price
		column :product_number
		column :inventory
		column :spec
		column :desc
		column :is_show
		actions
 	end

 	form(:html => { :multipart => true }) do |f|
    f.inputs "ValueableProduct" do
      f.input :name
      f.input :price
      f.input :product_number
      f.input :inventory
      f.input :spec
      f.input :desc
      f.input :is_show
      f.input :image, as: :file
      f.input :contents_category
    end
    f.actions
  end

end
