class AddColumnsToScoinTypes < ActiveRecord::Migration[5.0]
  def change
    add_column :coin_types, :type, :string
    add_column :coin_types, :days, :integer

    say_with_time "set default type" do
      CoinType.update_all(type: "ScoinType")
    end

  end
end
