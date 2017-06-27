class Unine < ApplicationRecord
  include RecordableConcern
  belongs_to :user
  validates :value, presence: true
end
