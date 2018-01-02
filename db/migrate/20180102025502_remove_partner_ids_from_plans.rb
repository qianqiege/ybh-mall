class RemovePartnerIdsFromPlans < ActiveRecord::Migration[5.0]
  def change
    remove_column :plans, :partner_ids, :string
  end
end
