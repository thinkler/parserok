class CreateInstRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :inst_records do |t|
      t.string :tattoo_theme
      t.text :dirty_links
      t.text :pure_links

      t.timestamps
    end
  end
end
