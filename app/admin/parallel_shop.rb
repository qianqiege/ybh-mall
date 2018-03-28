ActiveAdmin.register ParallelShop do
    menu parent: I18n.t("active_admin.menu.parallel_shop_manage")
    permit_params :title, :address, :main_business, :image, :desc, :plan_id, :status, :admin_user_id, :settlement_ratio, :is_hot, :left_and_right_ratio, :shop_type
    form(:html => { :multipart => true }) do |f|
      f.inputs "影子店" do
        f.input :plan
        f.input :title
        f.input :province,as: :select, collection: options_for_select(ChinaCity.list, @address.try(:province))
        f.input :address
        f.input :main_business
        f.input :image, as: :file
        f.input :desc
        if current_admin_user.role_name == "admin" || current_admin_user.role_name == "customer_service"
            f.input :status
            f.input :admin_user
            f.input :settlement_ratio
            f.input :left_and_right_ratio
        end
        f.input :is_hot
        f.input :shop_type, as: :select, collection: options_for_select(["御邦平行店", "医通影子店"])
      end
      f.actions
    end
    index do
        selectable_column
        id_column
        column :plan
        column :title
        column :admin_user
        column :address
        column :main_business
        column :settlement_ratio
        column :left_and_right_ratio
        column :shop_type
        column "营业员" do |parallelshop|
          parallelshop.users.pluck(:name).join(',')
        end
        column "影子店图片" do |slide|
          image_tag(slide.image_url, size: "72x45", :alt => "parallel shop image")
        end
        column :desc
        if current_admin_user.role_name == "admin"
            column "影子店审核" do |shop|
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
        end
        column "添加营业员" do |shop|
            link_to "添加营业员", edit_waiter_admin_parallel_shop_path(shop), method: :get
        end
        column :is_hot
        actions
    end

    member_action :edit_waiter, method: :get do
        shop_id = params[:id].to_i
        render partial: 'pages/edit_waiter', locals: {shop: shop_id}
    end

    member_action :add_waiter, method: :get do
        user = User.find_by(telphone:params[:phone])
        if user
            user.parallel_shop_id = params[:id].to_i
            user.save
            redirect_to admin_parallel_shops_path
        else
            render text:"该手机号未注册御易健!"
        end
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
