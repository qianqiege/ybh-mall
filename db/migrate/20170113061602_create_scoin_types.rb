class CreateScoinTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :scoin_types do |t|
      t.string :name
      t.decimal :once
      t.decimal :everyday
      t.decimal :count

      t.timestamps
    end
  end
end
