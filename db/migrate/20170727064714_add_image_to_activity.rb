class AddImageToActivity < ActiveRecord::Migration[5.0]
  def change
    add_column :activities, :image, :string
    add_column :activities, :url, :string
    add_column :activities, :desc, :string
  end
end
