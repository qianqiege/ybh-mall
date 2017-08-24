class CreateHightTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :hight_tickets do |t|
      t.integer :user_id
      t.integer :number

      t.timestamps
    end
  end
end
