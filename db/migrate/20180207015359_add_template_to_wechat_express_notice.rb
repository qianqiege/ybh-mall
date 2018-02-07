class AddTemplateToWechatExpressNotice < ActiveRecord::Migration[5.0]
  def change
    add_column :wechat_express_notices, :template, :string
  end
end
