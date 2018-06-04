class UpdateYterProfileToUsers < ActiveRecord::Migration[5.0]
  def up
    change_column :users, :yter_profile, :integer, default: 0
  end

  def down
    change_column :users, :yter_profile, :string, default: "未参与"
  end
end
