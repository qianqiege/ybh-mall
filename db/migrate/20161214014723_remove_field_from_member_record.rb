class RemoveFieldFromMemberRecord < ActiveRecord::Migration[5.0]
  def change
    remove_column :member_records,:name, :string
    remove_column :member_records,:sex, :string
    remove_column :member_records,:address, :string
    remove_column :member_records,:birthday,  :datetime
    remove_column :member_records,:mobile, :string
    remove_column :member_records,:emergency_contact, :string
    remove_column :member_records,:telephone, :string
    remove_column :member_records,:identity_card, :string
  end
end
