ActiveAdmin.register MemberEquity do
  menu parent: I18n.t("active_admin.menu.member_manage")
  permit_params :price,
                :number_of_time,
                :number,
                :serve_id,
                :product_id,
                :membership_card_id,
                :remark
end
