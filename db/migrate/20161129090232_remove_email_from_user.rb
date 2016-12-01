class RemoveEmailFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :email, :string
    add_column :users, :telphone, :string
  end
end
