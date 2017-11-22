class AddStateToApplyCode < ActiveRecord::Migration[5.0]
  def change
    add_column :apply_codes, :state, :string
  end
end
