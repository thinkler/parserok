class CreatePinRecrods < ActiveRecord::Migration[5.0]
  def change
    create_table :pin_records do |t|
      t.string :account_name
      t.text :followers
      t.text :followings
      t.text :bastards

      t.timestamps
    end
  end
end
