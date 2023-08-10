class AddMaterialTankSerialToTankLogs < ActiveRecord::Migration[7.0]
  def change
    add_column :tank_logs, :material_tank_serial, :string
  end
end
