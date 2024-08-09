class CreateWeddings < ActiveRecord::Migration[7.1]
  def change
    create_table :weddings do |t|
      t.string :title
      t.datetime :date
      t.string :location
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
