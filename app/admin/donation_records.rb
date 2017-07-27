ActiveAdmin.register DonationRecord do
  menu parent: I18n.t("active_admin.menu.coin_record_manage")
  permit_params :user_id,
                :price,
                :integral,
                :cash,
                :count_price,
                :order_number,
                :reason
end
