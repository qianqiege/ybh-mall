class Appraise < ApplicationRecord
  include PresentedConcern
  belongs_to :user
  validates :number, presence: true ,uniqueness: true
  after_create :create_health_record_give_ycoin

  def create_health_record_give_ycoin
  end

end
