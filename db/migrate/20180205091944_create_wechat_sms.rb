class CreateWechatSms < ActiveRecord::Migration[5.0]
  def change
    create_table :wechat_sms do |t|
      t.string :name
      t.string :template
      t.string :first
      t.string :keyword1
      t.string :keyword2
      t.string :keyword3
      t.string :remark

      t.timestamps
    end
  end
end
