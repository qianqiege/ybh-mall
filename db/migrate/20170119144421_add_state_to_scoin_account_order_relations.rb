class AddStateToScoinAccountOrderRelations < ActiveRecord::Migration[5.0]
  def change
    add_column :scoin_account_order_relations, :status, :string
  end
end
