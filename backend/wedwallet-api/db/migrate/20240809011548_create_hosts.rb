class CreateHosts < ActiveRecord::Migration[7.1]
  def change
    create_table :hosts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :wedding, null: false, foreign_key: true

      t.timestamps
    end
  end
end
