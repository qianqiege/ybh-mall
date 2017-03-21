class AddOrganizationIdToLssueCurrency < ActiveRecord::Migration[5.0]
  def change
    add_column :lssue_currencies, :organization_id, :integer
  end
end
