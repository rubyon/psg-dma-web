class CreateAnalogValues < ActiveRecord::Migration[7.0]
  def change
    create_table :analog_values do |t|
      t.decimal :value1, precision: 10, scale: 1
      t.decimal :value2, precision: 10, scale: 1
      t.decimal :value3, precision: 10, scale: 1
      t.decimal :value4, precision: 10, scale: 1
      t.decimal :value5, precision: 10, scale: 1
      t.decimal :value6, precision: 10, scale: 1
      t.decimal :value7, precision: 10, scale: 1
      t.decimal :value8, precision: 10, scale: 1
      t.decimal :value9, precision: 10, scale: 1
      t.decimal :value10, precision: 10, scale: 1
      t.decimal :value11, precision: 10, scale: 1
      t.decimal :value12, precision: 10, scale: 1
      t.decimal :value13, precision: 10, scale: 1
      t.decimal :value14, precision: 10, scale: 1
      t.decimal :value15, precision: 10, scale: 1
      t.decimal :value16, precision: 10, scale: 1
      t.decimal :value17, precision: 10, scale: 1
      t.decimal :value18, precision: 10, scale: 1
      t.timestamps
    end
  end
end
