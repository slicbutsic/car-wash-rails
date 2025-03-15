class CreatePrices < ActiveRecord::Migration[7.1]
  def change
    create_table :prices do |t|
      t.decimal :price
      t.references :service, null: false, foreign_key: true
      t.references :vehicle_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
