class Activity < ApplicationRecord
  has_many :activity_rules
  has_many :orders
end
