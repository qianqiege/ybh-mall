class UpdateYterProfileFromUsers < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      UPDATE `users` SET `yter_profile` = 0;
    SQL
  end

  def down
    execute <<-SQL
      UPDATE `users` SET `yter_profile` = '未参与';
    SQL
  end
end
