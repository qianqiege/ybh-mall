class AddDatetimeToSpdBusinessBatches < ActiveRecord::Migration[5.0]
  def change
    add_column :spd_business_batches, :product_datetime, :datetime
    add_column :spd_business_batches, :expire_datetime, :datetime
  end
end
