class AddIsShowToActivity < ActiveRecord::Migration[5.0]
  def change
    add_column :activities, :is_show, :boolean
  end
end
