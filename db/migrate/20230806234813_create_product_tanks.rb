class CreateProductTanks < ActiveRecord::Migration[7.0]
  def change
    create_table :product_tanks do |t|
      t.string :serial
      t.string :weight
      t.string :capacity
      t.string :inspection_date
      t.timestamps
    end
  end
end
