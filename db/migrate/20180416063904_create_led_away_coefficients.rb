class CreateLedAwayCoefficients < ActiveRecord::Migration[5.0]
  def change
    create_table :led_away_coefficients do |t|
      t.string :name
      t.float :coefficient

      t.timestamps
    end
  end
end
