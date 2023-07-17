class CreateAnalogs < ActiveRecord::Migration[7.0]
  def change
    create_table :analogs do |t|
      t.references :page, null: false, foreign_key: true
      t.integer :tile_id
      t.string :name
      t.integer :font_size
      t.string :font_color
      t.integer :offset_x
      t.integer :offset_y
      t.string :align
      t.integer :scale
      t.integer :modbus_index

      t.timestamps
    end
  end
end
