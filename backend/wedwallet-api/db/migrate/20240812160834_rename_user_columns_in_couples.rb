class RenameUserColumnsInCouples < ActiveRecord::Migration[7.0]
  def change
    rename_column :couples, :user1_id, :partner1_id
    rename_column :couples, :user2_id, :partner2_id
  end
end
