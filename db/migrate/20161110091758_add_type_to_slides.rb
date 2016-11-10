class AddTypeToSlides < ActiveRecord::Migration[5.0]
  def change
    add_column :slides, :tp, :integer, default: '1'
  end
end
