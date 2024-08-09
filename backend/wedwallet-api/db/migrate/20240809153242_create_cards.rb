class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards do |t|
      t.references :sender, null: false, foreign_key: true
      t.references :recipient, null: false, foreign_key: true
      t.references :wedding, null: false, foreign_key: true
      t.text :message
      t.string :card_type
      t.string :photo
      t.string :video

      t.timestamps
    end
  end
end
