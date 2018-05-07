class Warehouse < ApplicationRecord
  has_many :spd_stocks
  has_many :downs, class_name: "Warehouse", foreign_key: "up_id"
  belongs_to :up, class_name: "Warehouse"
  belongs_to :organization
end
