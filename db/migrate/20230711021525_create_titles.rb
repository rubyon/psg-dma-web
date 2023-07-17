class CreateTitles < ActiveRecord::Migration[7.0]
  def change
    create_table :titles do |t|
      t.references :page, null: false, foreign_key: true
      t.integer :tile_id
      t.integer :font_size
      t.string :font_color
      t.string :text
      t.integer :offset_x
      t.integer :offset_y
      t.string :align
      t.integer :scale

      t.timestamps
    end
  end
end