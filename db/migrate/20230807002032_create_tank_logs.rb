class CreateTankLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :tank_logs do |t|
      t.string :serial
      t.string :capacity_filled
      t.string :moisture_quantity
      t.string :purity_analysis
      t.timestamps
    end
  end
end
