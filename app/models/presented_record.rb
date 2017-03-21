class PresentedRecord < ApplicationRecord

  belongs_to :user
  belongs_to :presentable, polymorphic: true

  after_create :update_ycoin

  validates :user_id, presence: true
  validates :number, presence: true

  def update_ycoin
    @company = LssueCurrency.where(organization_id: Organization.find_by(only_number: "0001" ))
    @company.each do |coin|
      while coin.count > 0 && coin.count > number
        coin.count -= number
        if coin.save
          break
        end
      end
    end
    user.y_coin += number
    user.save
  end
end
