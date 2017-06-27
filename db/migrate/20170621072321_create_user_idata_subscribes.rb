class CreateUserIdataSubscribes < ActiveRecord::Migration[5.0]
  def change
    create_table :user_idata_subscribes do |t|
      t.text :list
      t.integer :user_id

      t.timestamps
    end
  end
end
