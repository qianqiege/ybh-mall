class CreateCompanyProgresses < ActiveRecord::Migration[5.0]
  def change
    create_table :company_progresses do |t|
      t.date :date
      t.text :desc
      t.string :image

      t.timestamps
    end
  end
end
