class CreatePinRecrods < ActiveRecord::Migration[5.0]
  def change
    create_table :pin_records do |t|
      t.string :account
      t.text :bastards

      t.timestamps
    end
  end
end
