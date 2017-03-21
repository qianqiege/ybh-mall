ActiveAdmin.register LssueCurrency do
  menu parent: I18n.t("active_admin.menu.coin_manage")
  permit_params :account, :count, :income, :expenditure, :organization_id
end
