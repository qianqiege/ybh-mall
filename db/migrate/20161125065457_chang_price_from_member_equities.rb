class ChangPriceFromMemberEquities < ActiveRecord::Migration[5.0]
  def change
    remove_column :member_equities, :total_price, :integer
    add_column :member_equities, :price, :decimal
  end
end
