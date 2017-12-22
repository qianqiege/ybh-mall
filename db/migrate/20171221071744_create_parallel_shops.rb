class CreateParallelShops < ActiveRecord::Migration[5.0]
  def change
    create_table :parallel_shops do |t|
      t.string :title
      t.string :address
      t.string :main_business
      t.string :image
      t.string :desc

      t.timestamps
    end
  end
end
