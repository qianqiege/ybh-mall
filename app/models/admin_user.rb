class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  ROLE_NAME_DATA = { member: '成员', admin: '管理员', db: '仓库管理员' }.freeze

  def role_name_label
    ROLE_NAME_DATA[self.role_name.to_sym]
  end
end
