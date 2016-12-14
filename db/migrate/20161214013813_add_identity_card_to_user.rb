class AddIdentityCardToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :identity_card, :string
  end
end
