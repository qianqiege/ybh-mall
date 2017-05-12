class CreateAdvices < ActiveRecord::Migration[5.0]
  def change
    create_table :advices do |t|
      t.string :content
      t.string :response
      t.integer :advice_type_id

      t.timestamps
    end
  end
end
