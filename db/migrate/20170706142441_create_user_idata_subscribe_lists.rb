class CreateUserIdataSubscribeLists < ActiveRecord::Migration[5.0]
  def change
    create_table :user_idata_subscribe_lists do |t|
      t.text :list

      t.timestamps
    end
  end
end
