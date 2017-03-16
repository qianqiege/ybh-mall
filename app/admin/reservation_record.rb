ActiveAdmin.register ReservationRecord do
  menu parent: I18n.t("active_admin.menu.serve_manage")
  permit_params :time, :name,:identity_card,:spine_build_id

    form(:html => { :multipart => true }) do |f|
      f.inputs "预约记录" do
        f.input :time
        f.input :name
        f.input :identity_card
        f.input :spine_build
      end
      f.actions
  end
end
