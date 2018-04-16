ActiveAdmin.register LedAwayCoefficient do
  menu parent: I18n.t( "active_admin.menu.mall")
  permit_params :name, :coefficient
  index do
    selectable_column
    id_column
    column :name
    column :coefficient
    actions
  end
#form
  form do |led_away_coefficient|
    led_away_coefficient.inputs do
      led_away_coefficient.input :name
      led_away_coefficient.input :coefficient
    end
    led_away_coefficient.actions
  end
#show
  show do
    attributes_table do
      row :name
      row :coefficient
    end
  end

end
