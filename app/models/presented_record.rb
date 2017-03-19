class PresentedRecord < ApplicationRecord

  belongs_to :user
  belongs_to :presentable, polymorphic: true

  after_create :update_ycoin

  validates :user_id, presence: true
  validates :number, presence: true

  def update_ycoin
    user.y_coin += number
    user.save
  end
end
