class AddYterProfileToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :yter_profile, :string, default: '未参与'
  end
end
