class AddLinkToPlanRules < ActiveRecord::Migration[5.0]
  def change
    add_column :plan_rules, :link, :string
  end
end
