ActiveAdmin.register ParallelShop do
    menu parent: I18n.t("active_admin.menu.parallel_shop_manage")
    permit_params :title, :address, :main_business, :image, :desc, :user_id, :status
    form(:html => { :multipart => true }) do |f|
      f.inputs "平行店" do
        f.input :user
        f.input :title
        f.input :address
        f.input :main_business
        f.input :image
        f.input :status
        f.input :desc
      end
      f.actions
    end
    index do
        selectable_column
        id_column
        column :user
        column :title
        column :address
        column :main_business
        column :image
        column :desc
        column "平行店审核" do |shop|
            if shop.status == "waiting"
              span do
                link_to '通过', pass_admin_parallel_shop_path(shop),method: :put, data: { confirm: 'Are you sure?' }
              end
              span do
                link_to '不通过', not_pass_admin_parallel_shop_path(shop),method: :put, data: { confirm: 'Are you sure?' }
              end
            else
               shop.get_status
            end
        end
        actions
    end

    member_action :pass, method: :put do
        resource.pass
        redirect_to admin_parallel_shops_path
    end

    member_action :not_pass, method: :put do
        resource.not_pass
        redirect_to admin_parallel_shops_path
    end
end
