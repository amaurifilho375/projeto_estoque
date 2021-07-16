class CreateMovimentations < ActiveRecord::Migration[6.1]
  def change
    create_table :movimentations do |t|
      t.string :type, limit: 1
      t.integer :quantities
      t.datetime :date

      t.timestamps
    end
  end
end
