ActiveAdmin.register MemberRecord do
  menu parent: I18n.t("active_admin.menu.record_manage")
  permit_params :member_number, :initiation_time,:user_id,:affiliation,:membership_card_id
  
  form(:html => { :multipart => true }) do |f|
    f.inputs "档案" do
      f.input :affiliation
      f.input :member_number
      f.input :initiation_time
      f.input :user
      f.input :membership_card
    end
    f.actions
  end
end
