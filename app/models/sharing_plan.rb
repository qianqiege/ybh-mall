class SharingPlan < ApplicationRecord
  has_many :plan_rules
  has_many :plans, through: :plan_rules
  def display_name
    "#{self.name}----#{self.plan_type}"
  end
end
