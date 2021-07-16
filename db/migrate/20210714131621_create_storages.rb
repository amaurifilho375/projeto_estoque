class CreateStorages < ActiveRecord::Migration[6.1]
  def change
    create_table :storages do |t|
      t.string :name, limit: 20
      t.references :movimentation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
