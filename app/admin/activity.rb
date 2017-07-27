ActiveAdmin.register Activity do
  menu parent: I18n.t("active_admin.menu.activity_manage")
  permit_params :name,:start_time,:stop_time,:is_show,:url,:image

  form(:html => { :multipart => true }) do |f|
    f.inputs "活动" do
      f.input :name
      f.input :start_time, as: :datepicker
      f.input :stop_time, as: :datepicker
      f.input :is_show
      f.input :image ,as: :file
      f.input :url
    end
    f.actions
  end

  member_action :set_default, method: :put do
    Activity.update_all is_default: false
    resource.is_default = true
    if resource.save
      redirect_to :back, notice: "已设为默认活动!"
    else
      redirect_to :back, notice: "操作失败!"
    end
  end

  index do
    selectable_column
    id_column

    column "活动图片" do |slide|
      image_tag(slide.image_url, size: "72x45", :alt => "activity image")
    end
    column :name
    column :start_time
    column :stop_time
    column :is_show
    column :is_default
    column :url
    actions do |activity|
      span do
        link_to '设为默认活动', set_default_admin_activity_path(activity), method: :put, data: { confirm: 'Are you sure?' } unless activity.is_default
      end
    end
  end

end
