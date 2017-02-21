class AddPhoneToWeight < ActiveRecord::Migration[5.0]
  def change
    add_column :weights, :phone, :string
    add_column :weights, :state, :string
  end
end
