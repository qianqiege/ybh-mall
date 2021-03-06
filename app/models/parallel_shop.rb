class ParallelShop < ApplicationRecord
  SHOP_TYPE = {'1' => '医通平行店', '2' => '医通影子店'}.freeze
  STATUS = {'waiting' => "待审核", 'dealed' => "已通过"}.freeze
  include ImageConcern
  has_many :purchase_orders
  has_many :stock_outs
  has_many :day_deals
  has_many :month_deal
  has_many :sale_products
  has_many :stock
  has_many :users
  has_many :shop_orders
  has_many :celebrate_ratsimps
  belongs_to :plan
  belongs_to :admin_user

  include AASM
  aasm column: :status do
    # 初始化状态
    state :waiting, :initial => true

    #  已审核
    state :dealed

    # 未通过审核
    state :not

    event :pass do
      transitions from: :waiting, to: :dealed
      after do
        self.save
      end
    end

    event :not_pass do
      transitions from: :waiting, to: :not
      after do
        self.save
      end
    end
  end

  # before_create :add_location

  def get_status
    if status == "waiting"
      "待处理"
    elsif status == "dealed"
      "审核通过"
    else
      "未通过审核"
    end
  end

  def display_detail
    "#{ChinaCity.get(province)} #{ChinaCity.get(city)} #{ChinaCity.get(street)} #{detail}"
  end

  # 生成一个id，title的二维数组
  # ['lisbon', 1], ['Madrid', 2]...]
  def self.get_id_with_title
    arr = []
    ParallelShop.pluck(:id).each do |id|
      item = []
      title = ParallelShop.find(id).title
      p "@"*30
      p title
      p id
      item.push(title);
      item.push(id);
      p item
      arr.push(item)
      p arr
    end
    return arr
  end

  def shop_type_name
    SHOP_TYPE[self.shop_type.to_s]
  end

  def status_name
    STATUS[self.status.to_s]
  end

  private
  def add_location
    qq_lbs = Sdk::QQLbs.new
    data = qq_lbs.geocoder_by_address(display_detail)
    self.latitude = data["result"]["location"]["lat"]
    self.longitude = data["result"]["location"]["lng"]
  end

end
