class ChangIdentityCardFromVipRecord < ActiveRecord::Migration[5.0]
  def change
    remove_column :vip_records, :identity_card , :integer
    add_column :vip_records, :identity_card , :string
  end
end
