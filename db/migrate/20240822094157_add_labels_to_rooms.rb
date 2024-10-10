class AddLabelsToRooms < ActiveRecord::Migration[7.1]
  def change
    add_column :rooms, :labels, :text, array: true
    add_column :rooms, :status, :integer, default: 0
    add_reference :rooms, :organization, foreign_key: true, type: :uuid
  end
end
