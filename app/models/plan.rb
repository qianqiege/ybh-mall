class Plan < ApplicationRecord
    belongs_to :user

    serialize :partner_ids, Array
end
