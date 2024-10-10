class Chat < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms, id: :uuid do |t|
      t.string :name
      t.boolean :is_private, default: false

      t.timestamps
    end

    create_table :messages, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :room, null: false, foreign_key: true, type: :uuid
      t.text :body

      t.timestamps
    end

    create_table :participants, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, index: true, type: :uuid
      t.references :room, null: false, foreign_key: true, index: true, type: :uuid

      t.timestamps
    end
  end
end
