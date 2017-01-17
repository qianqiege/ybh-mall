class AddUserIdToCarts < ActiveRecord::Migration[5.0]
  def change
    add_reference :carts, :user
  end
end
