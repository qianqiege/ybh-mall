ActiveAdmin.register ShopPropagandaImage do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
menu parent: I18n.t("active_admin.menu.yb_work_manage")
permit_params :image, :shop_id

index do
    selectable_column
    id_column

    column "工作站宣传图片" do |slide|
      image_tag(slide.image_url, size: "72x45", :alt => "product image")
    end
    column :shop_id
    actions
  end


  form(:html => { :multipart => true }) do |f|
    f.inputs "Product" do
      f.input :image, as: :file
      f.input :shop
    end
    f.actions
  end

#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end


end
