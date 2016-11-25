class RemoveAffiliationFromVipType < ActiveRecord::Migration[5.0]
  def change
    remove_column :vip_types, :affiliation, :string
  end
end
