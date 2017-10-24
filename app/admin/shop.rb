ActiveAdmin.register Shop do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
menu parent: I18n.t("active_admin.menu.yb_work_manage")
permit_params :user_image, :license_image
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

	column :name
	column :address
	column :category
	column :license_number
	column :user_id_card
	column '营业执照' do |shop|
		image_tag(shop.license_image, size: "45x72", :alt => "user image")
	end
	column '运营人证件' do |shop|
		image_tag(shop.user_image, size: "45x72", :alt => "user image")
	end
	actions
end


end
