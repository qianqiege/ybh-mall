ActiveAdmin.register Order do
  menu parent: I18n.t("active_admin.menu.mall")

  permit_params :status, :express_number, :activity_id, :user_id, :price, :remark

  actions :index, :show

  csv do
    # column :wechat_user do |order|
    #   order.wechat_user.try(:name)
    # end
    column :user do |order|
      order.user.try(:name)
    end
    column :activity do |order|
      order.activity.try(:name)
    end
    column :price
    column :integral
    column :cash
    column :quantity
    column :lottery_prize
    column :desc
    column :number do |order|
      "#{order.number}\t"
    end
    column :pay_tp do |order|
      order.pay_type_state
    end
    column :payment do |order|
      order.payment_label
    end
    column :status do |order|
      order.human_state
    end
    column :created_at
  end

  controller do
    def update
      if params[:order] && params[:order][:status] == 'cancel' && resource.may_make_cancel?
        resource.make_cancel!
        redirect_to resource_path, notice: '已取消订单!'
      elsif params[:order] && params[:order][:express_number].present? && resource.may_send_product?
        resource.express_number = params[:order][:express_number]
        resource.save!
        resource.send_product!
        redirect_to resource_path, notice: '已设为发货状态!'
      else
        super
      end
    end
  end

  member_action :make_cancel, method: :put do
    if resource.may_make_cancel?
      resource.make_cancel!
      redirect_to :back, notice: "已取消订单!"
    else
      redirect_to :back, notice: "操作失败!"
    end
  end

  member_action :receive, method: :put do
    if resource.may_receive?
      resource.receive!
      redirect_to :back, notice: "已设为发货状态!"
    else
      redirect_to :back, notice: "操作失败!"
    end
  end

  member_action :pay, method: :put do
    if resource.may_pay?
      resource.pay_tp = 1
      resource.save!
      resource.pay!
      redirect_to :back, notice: "已设为线下支付!"
    else
      redirect_to :back, notice: "操作失败!"
    end
  end

  member_action :express_number, method: :get do
    render 'edit.html.arb', :layout => false
  end

  member_action :edit_price, method: :get do
    render 'edit.html.arb', :layout => false
  end

  member_action :pay_donation, method: :put do
    if resource.pay_donation
      redirect_to :back, notice: "操作成功!"
    else
      redirect_to :back, notice: "操作失败!"
    end
  end

  member_action :pay_cancel, method: :put do
    if resource.pay_cancel!
      redirect_to :back, notice: "已取消订单!"
    else
      redirect_to :back, notice: "操作失败!"
    end
  end

  member_action :return_order, method: :put do
    if resource.return_change!
      redirect_to :back, notice: "已取消订单!"
    else
      redirect_to :back, notice: "操作失败!"
    end
  end

  action_item :edit_price, only: :show do
    link_to '更改价格', edit_price_admin_order_path(resource), method: :get if current_admin_user.change_order?
  end

  index do
    selectable_column
    id_column

    # column :wechat_user
    column :user
    column :activity
    column :price
    column "YBZ方案",:packang
    column :integral
    column "现金余额",:cash
    column :quantity
    column '优惠券',:lottery_prize
    column :number
    column '付款类型' do |order|
      status_tag order.pay_type_state, order_pay_type_state_color(order.pay_tp)
    end
    column '支付类型' do |order|
      order.payment_label
    end
    column :status do |order|
      status_tag order.human_state, order_status_color(order.status)
    end
    column "支付操作" do |order|
      link_to '确认付款', pay_admin_order_path(order), method: :put, data: { confirm: 'Are you sure?' } if order.pending?
    end
    column "确认操作" do |order|
      link_to '确认已捐款', pay_donation_admin_order_path(order), method: :put, data: { confirm: 'Are you sure?' } if order.is_donation == true && order.wait_send?
    end
    column '创建时间',:created_at
    column '订单操作' do |order|
      span do
        link_to '取消订单', make_cancel_admin_order_path(order), method: :put, data: { confirm: 'Are you sure?' } if order.pending?
      end
      span do
        link_to '取消订单', pay_cancel_admin_order_path(order), method: :put, data: { confirm: 'Are you sure?' } if order.wait_send? && order.price <= 0
      end
      span do
        link_to '填写货运单号', express_number_admin_order_path(order, express_number: :yes), method: :get if order.wait_send? || order.wait_confirm?
      end
      span do
        link_to '设为已收货', receive_admin_order_path(order), method: :put, data: { confirm: 'Are you sure?' } if order.wait_confirm?
      end
      span do
        link_to '退货/退款', return_order_admin_order_path(order), method: :put, data: { confirm: 'Are you sure?' } if !order.return_change?
      end
    end
    actions defaults: true
  end

  form(:html => { :multipart => true }) do |f|
    f.input :status, as: :select, collection: Order::STATUS_TEXT.invert, include: false
    f.actions
  end

  filter :status, as: :select, collection: Order::STATUS_TEXT.invert, multiple: true
  filter :pay_tp, as: :select, collection: Order::PAY_TYPE_TEXT.invert
  filter :payment, as: :select, collection: Order::PAYMENT_TEXT.invert
  filter :wechat_user_mobile, as: :string
  filter :wechat_user, as: :select
  filter :user, as: :select
  filter :activity, as: :select

  show do |order|
    attributes_table do
      row :id
      row :wechat_user
      row :user_id
      row '手机号码' do
        order.wechat_user.mobile
      end
      row :initial_price do
        money order.initial_price
      end
      row :price do
        money order.price
      end
      row :integral
      row :status do
        order.human_state
      end
      row :quantity
      row :activity
      row '收货人' do
        order.address.contact_name
      end
      row '收货人联系方式' do
        order.address.mobile
      end
      row :address
      row :express_number
      row :remark
      row :desc
    end
    panel "订单项详情" do
      table_for order.line_items do |t|
        t.column('id') { |line_item| line_item.id }
        t.column('名称') { |line_item| line_item.product.name }
        t.column('图片') { |line_item| image_tag(line_item.product.image_url, size: "72x45", :alt => "product image") }
        t.column('数量') { |line_item| line_item.quantity }
        t.column('单价') { |line_item| line_item.unit_price }
        t.column('规格') { |line_item| line_item.product.spec }
      end
    end

    panel "物流信息" do
      div do
        if order.express_number.present? &&
            (express = order.remote_express_info) &&
            express["status"].to_i == 200

          express["data"].each do |data|
            div do
              "#{unix_time_to_datatime(data['time'].to_s)}：#{data['info']}"
            end
          end
        else
          "未有物流信息，可能没有填写物流单号或者查不到信息"
        end
      end
    end
  end

  # 目前只供填写货运单号使用，如果有其他用途需要做修改
  form(:html => { :multipart => true }) do |f|
    if params[:express_number].present?
      f.inputs "填写货运单号" do
        f.input :express_number
      end
    end
    if current_admin_user.change_order?
      f.inputs "价格" do
        f.input :price
        f.input :remark
      end
    end
    f.actions
  end
end
