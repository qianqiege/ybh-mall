class AddReviewToExchangeRecord < ActiveRecord::Migration[5.0]
  def change
    add_column :exchange_records, :review, :string
  end
end
