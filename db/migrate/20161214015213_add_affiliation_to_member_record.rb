class AddAffiliationToMemberRecord < ActiveRecord::Migration[5.0]
  def change
    add_column :member_records, :affiliation, :string
  end
end
