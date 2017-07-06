class AddStatusToUserIdataSubscribes < ActiveRecord::Migration[5.0]
  def change
    add_column :user_idata_subscribes, :status, :string, default: "fail"
  end
end
