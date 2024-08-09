class AddHostsToWeddings < ActiveRecord::Migration[7.0]
  def change
    add_column :weddings, :host_id, :integer
    add_column :weddings, :second_host_id, :integer

    add_index :weddings, :host_id
    add_index :weddings, :second_host_id
  end
end
