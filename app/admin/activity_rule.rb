ActiveAdmin.register ActivityRule do
  menu parent: I18n.t("active_admin.menu.activity_manage")
  permit_params :rule,:activity_id,:max,:min,:y_coin,:coin_type_id,:percent,:bronze,:silver,:gold
  index do
    selectable_column
    id_column

    column :activity
    column :rule
    column :max
    column :min
    column :y_coin
    column :coin_type
    column :percent
    column :bronze
    column :silver
    column :gold
    actions
  end

  form do |f|
    f.inputs "活动规则" do
      f.input :activity
      f.input :rule
      f.input :max
      f.input :min
      f.input :coin_type
      f.input :percent
      f.input :y_coin
      f.input :bronze
      f.input :silver
      f.input :gold
    end
    f.actions
  end


end
