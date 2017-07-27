class Activity < ApplicationRecord
  include ImageConcern
  has_paper_trail
  has_many :activity_rules
  has_many :orders
end
