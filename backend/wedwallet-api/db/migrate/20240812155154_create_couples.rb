class CreateCouples < ActiveRecord::Migration[7.1]
  def change
    create_table :couples do |t|
      t.integer :user1_id
      t.integer :user2_id

      t.timestamps
    end
  end
end
