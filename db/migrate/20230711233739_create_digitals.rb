class CreateDigitals < ActiveRecord::Migration[7.0]
  def change
    create_table :digitals do |t|
      t.references :page, null: false, foreign_key: true
      t.integer :tile_id
      t.string :name
      t.integer :on
      t.integer :off
      t.integer :modbus_bit

      t.timestamps
    end
  end
end
