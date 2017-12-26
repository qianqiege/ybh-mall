class AddNumberToPlans < ActiveRecord::Migration[5.0]
  def change
      add_column :plans, :code, :string
  end
end
