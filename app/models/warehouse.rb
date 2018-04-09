class Warehouse < ApplicationRecord
  belongs_to :organization
  has_many :downs, class_name: "Warehouse", foreign_key: "up_id"
  belongs_to :up, class_name: "Warehouse"
end
