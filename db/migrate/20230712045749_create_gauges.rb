class CreateGauges < ActiveRecord::Migration[7.0]
  def change
    create_table :gauges do |t|
      t.references :page, null: false, foreign_key: true
      t.integer :tile_id
      t.string :name
      t.integer :width
      t.integer :height
      t.integer :min
      t.integer :max
      t.integer :offset_x
      t.integer :offset_y
      t.string :foreground_color
      t.string :background_color
      t.integer :modbus_index

      t.timestamps
    end
  end
end
