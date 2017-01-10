class AddIdentityCardToLongProgram < ActiveRecord::Migration[5.0]
  def change
    add_column :long_programs, :identity_card, :string
  end
end
