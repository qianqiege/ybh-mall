ActiveAdmin.register FileAsset do
  permit_params :name, :location

  index do
    selectable_column
    id_column
    column :name
    column :location
    actions
  end

  filter :name

  form do |f|
    f.inputs "文件资源" do
      f.input :name
      f.input :location
    end
    f.actions
  end

  show do |admin_user|
    attributes_table do
      row :name
      row :location
    end
  end
end
