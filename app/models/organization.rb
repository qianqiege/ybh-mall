class Organization < ApplicationRecord
  has_many :users
  has_many :lssue_currencies
end
