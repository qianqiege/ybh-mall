class AddVerifyCodeToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :verify_code, :string
    add_column :users, :verify_code_expired_at, :datetime
    add_column :users, :verified_at, :datetime
    add_column :users, :authentication_token, :string
  end
end
