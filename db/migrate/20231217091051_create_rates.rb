class CreateRates < ActiveRecord::Migration[7.1]
  def change
    create_table :rates do |t|
      t.references :currency, null: false, foreign_key: true
      t.decimal :value
      t.date :date

      t.timestamps
    end

    add_index :rates, [:date, :currency_id], unique: true
  end
end
