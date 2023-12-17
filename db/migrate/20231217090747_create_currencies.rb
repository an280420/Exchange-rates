class CreateCurrencies < ActiveRecord::Migration[7.1]
  def change
    create_table :currencies do |t|
      t.string :code, null: false
      t.string :name

      t.timestamps
    end

    add_index :currencies, :cbr_code, unique: true
  end
end
