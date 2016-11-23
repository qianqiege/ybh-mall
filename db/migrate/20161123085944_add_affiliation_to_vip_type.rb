class AddAffiliationToVipType < ActiveRecord::Migration[5.0]
  def change
    add_column :vip_types, :affiliation, :string
  end
end
