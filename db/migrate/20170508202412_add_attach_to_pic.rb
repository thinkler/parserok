class AddAttachToPic < ActiveRecord::Migration[5.0]
  def change
    def up
      add_attachment :images, :avatar
    end

    def down
      remove_attachment :images, :avatar
    end
  end
end
