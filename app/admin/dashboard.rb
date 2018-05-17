ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc {I18n.t("active_admin.dashboard")}

  content title: proc {I18n.t("active_admin.dashboard")} do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end
    columns do
      if current_admin_user.role_name == 'parent_company_admin'
        column do
          panel "御易健订单" do
            table_for Order.where(status: ["wait_send", "pedding"]).first(5) do |order|
              order.column('单号') {|spd_business_batches| spd_business_batches.number}
              order.column('订单状态') {|spd_business_batches| spd_business_batches.status}
              order.column('查看') {|spd_business_batches| link_to "查看", admin_order_path(spd_business_batches)}
            end
          end
        end
      end
      if !current_admin_user.organization.nil?
        column do
          panel "待处理理任务" do
            table_for SpdBusiness.where(warehouse_id: current_admin_user.try(:organization).try(:warehouses).try(:ids))
                          .where("purchase_status in (?) or allocate_status in (?) or distribute_status in (?)", ["applying", "pedding"], ["applying", "pedding"], ["applying", "pedding"]) do |batch|
              batch.column('单号') {|spd_business_batches| spd_business_batches.business_number}
              batch.column('业务仓库') {|spd_business_batches| spd_business_batches.try(:warehouse).try(:name)}
              batch.column('创建日期') {|spd_business_batches| spd_business_batches.created_at.to_date}
            end
          end
        end
      end
      if current_admin_user.role_name.in? ['parent_company_admin', 'province_admin']
        column do
          panel "产品效期预警(提前90天)" do
            table_for SpdStockBatch.where("expire_datetime < ?", Time.now + 90.day) do |batch|
              batch.column('产品名称') {|spd_stock_batch| spd_stock_batch.spd_stock.product.name}
              batch.column('所属仓库') {|spd_stock_batch| spd_stock_batch.spd_stock.warehouse.name}
              batch.column('批次') {|spd_stock_batch| spd_stock_batch.batch}
              batch.column('数量') {|spd_stock_batch| spd_stock_batch.count}
              batch.column('到期日期') {|spd_stock_batch| spd_stock_batch.expire_datetime.to_date}
            end
          end
        end
      end
    end
  end

end
