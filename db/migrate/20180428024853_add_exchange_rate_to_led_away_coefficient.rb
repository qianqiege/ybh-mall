class AddExchangeRateToLedAwayCoefficient < ActiveRecord::Migration[5.0]
  def change
  	add_column :led_away_coefficients, :exchange_rate, :float
  end
end
