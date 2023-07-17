class AddLinkToTitles < ActiveRecord::Migration[7.0]
  def change
    add_column :titles, :link, :string
  end
end
