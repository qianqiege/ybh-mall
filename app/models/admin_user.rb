class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :parallel_shop
  belongs_to :organization

  ROLE_NAME_DATA = { member: '成员',
                    admin: '管理员',
                    db: '仓库管理员',
                    spinebuild:'筑脊部管理员',
                    mall:'医通平行店管理员',
                    scoin_admin:'S货币管理员',
                    activity_admin:'活动管理员',
                    market: '市场部管理',
                    finance:'财务管理',
                    customer_service:'客户服务',
                    tester: '测试人员',
                    parallel_shop: '店铺管理者',
                    parent_company_admin: '总公司管理员',
                    province_admin:'省级平台公司管理员'}.freeze

  def role_name_label
    ROLE_NAME_DATA[self.role_name.to_sym]
  end

  def change_order?
    self.email == "change_order@ybyt.com"
  end

  def name
      self.email
  end
end
