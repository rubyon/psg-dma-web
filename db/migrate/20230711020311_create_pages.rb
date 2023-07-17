class CreatePages < ActiveRecord::Migration[7.0]
  def change
    create_table :pages do |t|
      t.string  :title
      t.integer :sort_order, null: false, default: 0
      t.timestamps
    end
  end
end
