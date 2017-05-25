class Advice < ApplicationRecord
	belongs_to :advice_type

	validates_length_of :content, message: "问题描述不能少于6", minimum: 6
	
end
