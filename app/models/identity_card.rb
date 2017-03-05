class IdentityCard < ApplicationRecord
  include ImageConcern
  belongs_to :user
end
