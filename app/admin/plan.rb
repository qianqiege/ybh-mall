ActiveAdmin.register Plan do
    permit_params :user_id, :partner_ids, :is_capital, :capital_id, :active, :is_maker, :money
    form(:html => { :multipart => true }) do |f|
      f.inputs "评价" do
        f.input :user
        f.input :partner_ids
        f.input :is_capital
        f.input :capital_id
        f.input :active
        f.input :is_maker
        f.input :money
      end
      f.actions
    end
    index do
        selectable_column
        id_column
        column :user
        column :code
        column :partner_ids
        column :is_capital
        column :capital_id
        column :active
        column :is_maker
        column :money
        actions
    end
end
