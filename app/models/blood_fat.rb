class BloodFat < ApplicationRecord
  include RecordableConcern
  
  belongs_to :user
end
