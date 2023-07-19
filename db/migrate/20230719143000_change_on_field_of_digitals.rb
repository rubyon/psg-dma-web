# 파일명: YYYYMMDDHHMMSS_change_on_field_of_digitals.rb
class ChangeOnFieldOfDigitals < ActiveRecord::Migration[6.0]
  def change
    rename_column :digitals, :on, :on_1
    add_column :digitals, :on_2, :integer
    add_column :digitals, :on_3, :integer
  end
end
