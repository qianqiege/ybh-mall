ActiveAdmin.register Deposit do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
menu parent: I18n.t("active_admin.menu.coin_record_manage")


actions :index, :show

index do
	selectable_column
   	id_column

   	column "用户", :user_id
	column "充值订单号", :number
	column "充值金额", :price
    column '付款类型' do |deposit|
      deposit.payment == "PAYMENT_TYPE_YJ" ? "银行卡支付" : "微信支付"
    end
    column "状态", :status
    column "充值订单创建时间", :created_at

    actions
end





end
