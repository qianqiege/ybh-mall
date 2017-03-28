class Appraise < ApplicationRecord
  include PresentedConcern
  belongs_to :user
  validates :number, presence: true ,uniqueness: true
  after_create :create_health_record_give_ycoin

  def create_health_record_give_ycoin
    presented_records.create(user_id: user.id, number: 88, reason: "建档")
  end

end
