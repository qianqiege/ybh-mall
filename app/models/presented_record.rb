class PresentedRecord < ApplicationRecord

  belongs_to :user
  belongs_to :presentable, polymorphic: true

  after_create :update_ycoin

  validates :user_id, presence: true
  validates :number, presence: true

  def update_ycoin
    ybyt = User.find_by(identity_card: 100000000000000000)
    ybyt.y_coin -= number
    ybyt.save
    user.y_coin += number
    user.save
  end
end
