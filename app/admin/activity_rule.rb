ActiveAdmin.register ActivityRule do
  menu parent: I18n.t("active_admin.menu.activity_manage")
  permit_params :rule,
                :donation,
                :activity_id,
                :max,
                :min,
                :y_coin,
                :coin_type_id,
                :percent,
                :bronze,
                :silver,
                :gold,
                :percentage,
                :staff,
                :family_doctor,
                :family_health_manager,
                :health_manager
  index do
    selectable_column
    id_column

    column :activity
    column :max
    column :min
    column :y_coin
    # column :coin_type
    column :percent
    column :staff
    column :percentage
    column :donation
    column :family_doctor
    column :family_health_manager
    column :health_manager
    actions
  end

  form do |f|
    f.inputs "活动规则" do
      f.input :activity
      f.input :rule
      f.input :max
      f.input :min
      f.input :coin_type
      f.input :y_coin
      f.input :percent
      f.input :percentage
      f.input :staff
      f.input :donation
      f.input :health_manager
      f.input :family_health_manager
      f.input :family_doctor
    end
    f.actions
  end


end
