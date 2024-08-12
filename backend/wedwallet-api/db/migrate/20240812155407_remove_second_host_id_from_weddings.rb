class RemoveSecondHostIdFromWeddings < ActiveRecord::Migration[7.1]
  def change
    remove_column :weddings, :second_host_id, :integer
  end
end
