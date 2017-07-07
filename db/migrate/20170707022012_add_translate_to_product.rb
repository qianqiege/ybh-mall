class AddTranslateToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :translate, :string
    add_column :products, :sort, :integer
  end
end
