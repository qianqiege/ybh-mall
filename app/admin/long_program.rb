ActiveAdmin.register LongProgram do
  menu parent: I18n.t("active_admin.menu.program_manage")
  permit_params :doctor,
                :hospital,
                :recipe_number,
                :total,
                :detail,
                :blood_letting,
                :treatment,
                :identity_card,
                :level,
                :time

  form(:html => { :multipart => true }) do |f|
    f.inputs "龙氏脊筑方案" do
    f.input :doctor
    f.input :hospital
    f.input :identity_card
    f.input :recipe_number
    f.input :total
    f.input :detail
    f.input :blood_letting
    f.input :treatment
    f.input :level
    f.input :time, as: :datepicker
    end
  f.actions
  end

end
