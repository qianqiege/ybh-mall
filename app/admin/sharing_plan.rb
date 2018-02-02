ActiveAdmin.register SharingPlan do
  menu parent: I18n.t("active_admin.menu.activity_manage")
  permit_params :name, :plan_type, :invite_count, :contract

  index do
    selectable_column
    id_column
    column :name
    column :invite_count
    column :plan_type
    actions
  end

  form(:html => { :multipart => true }) do |f|
    f.inputs "计划规则" do
      f.input :name
      f.input :invite_count
      f.input :contract, :as => :ckeditor
      f.input :plan_type, as: :select, collection: ['199', '177', '155', '133', '122', '1xx']
    end
    f.actions
  end

  show do |user|
    attributes_table do
      row :name
      row :invite_count
      row :plan_type
      row '合约内容' do |sharing_plan|
        truncate(raw sharing_plan.contract)
      end
    end
  end
end
