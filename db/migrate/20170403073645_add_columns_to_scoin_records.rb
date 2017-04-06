class AddColumnsToScoinRecords < ActiveRecord::Migration[5.0]
  def change
    add_column :coin_records, :type, :string
    add_column :coin_records, :account_type, :string
    rename_column(:coin_records, :scoin_type_id, :coin_type_id)
    rename_column(:coin_records, :scoin_account_id, :account_id)

    say_with_time "set default type" do
      CoinRecord.update_all(type: "ScoinRecord", account_type: "ScoinAccount")
    end

  end
end
