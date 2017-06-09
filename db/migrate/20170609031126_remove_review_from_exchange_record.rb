class RemoveReviewFromExchangeRecord < ActiveRecord::Migration[5.0]
  def change
    remove_column :exchange_records, :review, :string
  end
end
