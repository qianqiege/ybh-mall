class AddRemarkToMemberEquities < ActiveRecord::Migration[5.0]
  def change
    add_column :member_equities, :remark, :text
  end
end
