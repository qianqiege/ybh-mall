ActiveAdmin.register ParallelShop do
    menu parent: I18n.t("active_admin.menu.parallel_shop_manage")
    permit_params :title, :address, :main_business, :image, :desc, :plan_id, :status, :admin_user_id, :earning_ratio, :settlement_ratio
    form(:html => { :multipart => true }) do |f|
      f.inputs "平行店" do
        f.input :plan
        f.input :title
        f.input :address
        f.input :main_business
        f.input :image, as: :file
        f.input :status
        f.input :admin_user
        f.input :desc
        f.input :settlement_ratio
        f.input :earning_ratio
      end
      f.actions
    end
    index do
        selectable_column
        id_column
        column :plan
        column :title
        column :address
        column :main_business
        column :earning_ratio
        column :settlement_ratio
        column "平行店图片" do |slide|
          image_tag(slide.image_url, size: "72x45", :alt => "parallel shop image")
        end
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
