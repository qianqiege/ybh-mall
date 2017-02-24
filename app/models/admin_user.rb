class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  ROLE_NAME_DATA = { member: '成员',
                    admin: '管理员',
                    db: '仓库管理员',
                    spinebuild:'筑脊部管理员',
                    mall:'商城管理员',
                    scoin_admin:'S货币管理员',
                    activity_admin:'活动管理员',
                    market: '市场部管理'}.freeze

  def role_name_label
    ROLE_NAME_DATA[self.role_name.to_sym]
  end

  def change_order?
    self.email == "change_order@ybyt.com"
  end
end
