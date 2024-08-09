class RemoveUserIdFromWeddings < ActiveRecord::Migration[7.1]
  def change
    remove_column :weddings, :user_id, :integer
  end
end
