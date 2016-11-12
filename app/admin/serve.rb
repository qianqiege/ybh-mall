ActiveAdmin.register Serve do
  permit_params :serve_name,
                :serve_level,
                :serve_money

    form(:html => { :multipart => true }) do |f|
      f.inputs "服务" do
        f.input :serve_name
        f.input :serve_money
        f.input :serve_level
      end
      f.actions
  end
end
