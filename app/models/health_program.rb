class HealthProgram < ApplicationRecord
  include PresentedConcern
  validates :identity_card , presence: true ,length: { is: 18 }

  after_create :create_presented_record

  def create_presented_record
    presented_records.create(user_id: user_id , number: 300, reason: "开方赠送")
  end
end
