ActiveAdmin.register SharingPlan do
  menu parent: I18n.t("active_admin.menu.activity_manage")
  permit_params :name, :plan_type, :invite_count, :earning_ratio, :link_income_ratio, :product_ratio, :contract, :instruction

  index do
    selectable_column
    id_column
    column :name
    column :invite_count
    column :plan_type
    column :earning_ratio
    column :link_income_ratio
    column :product_ratio
    actions
  end

  form(:html => { :multipart => true }) do |f|
    f.inputs "计划规则" do
      f.input :name
      f.input :invite_count
      f.input :plan_type, as: :select, collection: ['199', '179', '159', '139', '129', '1x9']
      f.input :earning_ratio
      f.input :link_income_ratio
      f.input :product_ratio
      f.input :contract, :as => :ckeditor
      f.input :instruction, :as => :ckeditor
    end
    f.actions
  end

  show do |user|
    attributes_table do
      row :name
      row :invite_count
      row :plan_type
      row :earning_ratio
      row :link_income_ratio
      row :product_ratio
      row '合约内容' do |sharing_plan|
        truncate(raw sharing_plan.contract)
      end
      row '说明书' do |sharing_plan|
        truncate(raw sharing_plan.instruction)
      end
    end
  end
end
