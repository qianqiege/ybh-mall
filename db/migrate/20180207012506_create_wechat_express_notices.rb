class CreateWechatExpressNotices < ActiveRecord::Migration[5.0]
  def change
    create_table :wechat_express_notices do |t|
      t.string :first
      t.string :content
      t.string :location
      t.string :time
      t.text :remark
      t.timestamps
    end
  end
end
