class AddUrlToServe < ActiveRecord::Migration[5.0]
  def change
    add_column :serves, :url, :string
  end
end
