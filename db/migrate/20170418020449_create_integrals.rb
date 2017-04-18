class CreateIntegrals < ActiveRecord::Migration[5.0]
  def change
    create_table :integrals do |t|
      t.decimal :bronze
      t.decimal :silver
      t.decimal :gold
      t.integer :user_id

      t.timestamps
    end
  end
end
