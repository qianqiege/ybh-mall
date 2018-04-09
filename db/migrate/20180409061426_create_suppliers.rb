class CreateSuppliers < ActiveRecord::Migration[5.0]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :coding
      t.string :industry
      t.string :receivables
      t.string :accumulated_pay
      t.string :contact
      t.string :telephone

      t.timestamps
    end
  end
end
