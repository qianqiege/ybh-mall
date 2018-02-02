class PlanRule < ApplicationRecord
  belongs_to :sharing_plan
  has_many :plans
end
