class Organization < ApplicationRecord
  has_many :users
  has_many :lssue_currencies
  has_many :warehouses
  has_many :downs, class_name: "Organization", foreign_key: "up_id"
  belongs_to :up, class_name: "Organization"
end
