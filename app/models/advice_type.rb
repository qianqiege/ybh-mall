class AdviceType < ApplicationRecord
	has_many :advices, dependent: :destroy
end
