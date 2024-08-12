class CreateGifts < ActiveRecord::Migration[7.1]
  def change
    create_table :gifts do |t|
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.references :recipient, null: false, foreign_key: { to_table: :users }
      t.references :wedding, null: false, foreign_key: true
      t.decimal :amount
      t.text :message

      t.timestamps
    end
  end
end
