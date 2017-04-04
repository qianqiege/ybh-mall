ActiveAdmin.register YcoinType do
  menu parent: I18n.t("active_admin.menu.coin_manage")
  permit_params :name,:once,:everyday,:count,:days

  form(:html => { :multipart => true }) do |f|
    f.inputs "y货币包" do
      f.input :name
      f.input :once
      f.input :everyday
      f.input :days
    end
    f.actions
  end

  index do
    selectable_column
    id_column

    column :name
    column :once
    column :everyday
    column :count
    column :days
    actions
  end

  filter :name, as: :select
  filter :once, as: :select
  filter :everyday, as: :select
  filter :count, as: :select

end
