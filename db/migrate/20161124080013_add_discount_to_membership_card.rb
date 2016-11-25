class AddDiscountToMembershipCard < ActiveRecord::Migration[5.0]
  def change
    add_column :membership_cards, :discount, :float
    add_column :membership_cards, :allowance, :integer
  end
end
