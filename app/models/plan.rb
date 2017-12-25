class Plan < ApplicationRecord
    belongs_to :user
    has_many :parallel_shops
    
    serialize :partner_ids, Array
end
