class SpdBusiness < ApplicationRecord
  belongs_to :supplier
  belongs_to :warehouse
  belongs_to :parallel_shop
  belongs_to :up, class_name: 'SpdBusiness', optional: true
  has_many :downs, class_name: 'SpdBusiness', foreign_key: :up_id, dependent: :destroy
  has_many :spd_business_items, dependent: :destroy
  accepts_nested_attributes_for :spd_business_items
  has_many :spd_business_batches, through: :spd_business_items


  def self.number_prefix prefix
    @prefix = prefix
  end

  def self.generator_number params
    if params[:action] == "new"
      if !self.last.nil? && self.last.created_at.day == Time.now.day
        @prefix + "#{self.last.business_number[-12, 12].to_i + 1}"
      else
        @prefix + Time.now.strftime("%Y%m%d") + "0001"
      end
    elsif params[:action] == "edit"
      self.find(params["id"]).business_number
    end
  end
end
