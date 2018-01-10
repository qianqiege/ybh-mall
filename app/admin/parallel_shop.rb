ActiveAdmin.register ParallelShop do
    menu parent: I18n.t("active_admin.menu.parallel_shop_manage")
    permit_params :title, :address, :main_business, :image, :desc, :plan_id, :status, :admin_user_id, :settlement_ratio
    form(:html => { :multipart => true }) do |f|
      f.inputs "平行店" do
        f.input :plan
        f.input :title
        f.input :address
        f.input :main_business
        f.input :image, as: :file
        f.input :desc
        if current_admin_user.role_name == "admin"
            f.input :status
            f.input :admin_user
            f.input :settlement_ratio
        end
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
        column :settlement_ratio
        column "平行店图片" do |slide|
          image_tag(slide.image_url, size: "72x45", :alt => "parallel shop image")
        end
        column :desc
        if current_admin_user.role_name == "admin"
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
        end
        column "添加营业员" do |shop|
            link_to "添加营业员", edit_waiter_admin_parallel_shop_path(shop), method: :get
        end
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
