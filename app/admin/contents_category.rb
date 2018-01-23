ActiveAdmin.register ContentsCategory do
  permit_params :name, :up_id

  index do
    selectable_column
    id_column
    column :name
    column :up_id
    actions
  end
end
