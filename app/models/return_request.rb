class ReturnRequest < ApplicationRecord
  HUMAN_TYPE = { '0' => '换货', '1' => '退货' }.freeze
  belongs_to :line_item
  belongs_to :order
  validates :desc, length: { minimum: 10 }
  validates :line_item, :order, presence: true

  def human_tp
    HUMAN_TYPE[self.tp.to_s]
  end
end
