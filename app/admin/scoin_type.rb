ActiveAdmin.register ScoinType do
  menu parent: I18n.t("active_admin.menu.coin_manage")
  permit_params :name,:once,:everyday,:count, :remain_count

  form(:html => { :multipart => true }) do |f|
    f.inputs "s货币包" do
      f.input :name
      f.input :once
      f.input :everyday
      f.input :remain_count
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
    column :remain_count
    column :present_count
    actions
  end

  filter :name, as: :select
  filter :once, as: :select
  filter :everyday, as: :select
  filter :count, as: :select
  filter :remain_count, as: :select
  filter :present_count, as: :select

end
