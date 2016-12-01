class ConvertDatabaseToUtf8mb4 < ActiveRecord::Migration[5.0]
  def change
    execute "
      ALTER TABLE `wechat_users`
        CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
      MODIFY nickname VARCHAR(250)
          CHARACTER SET utf8mb4 COLLATE utf8mb4_bin
    "
  end
end
