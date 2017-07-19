class Evaluation < ApplicationRecord
  belongs_to :product
  has_many :evaluate_rules
end
