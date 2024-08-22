class WebsiteEntities < ActiveRecord::Migration[7.1]
  def change
    # Organization to scope rooms
    create_table :organizations do |t|
      t.string :name, null: false, default: ""
      t.string :website, null: false, default: ""
      t.belongs_to :owner, null: false, foreign_key: {to_table: :users}
      t.references :current_assignee, foreign_key: { to_table: :users }

      t.timestamps
    end
    # User to scope to Organizations
    add_column :users, :user_type, :integer, null: false, default: 0
    add_reference :users, :organizations, index: true

    # Rooms assignee
    add_reference :rooms, :assignee, foreign_key: { to_table: :users }

    # Messages source and targe language and text
    add_column :messages, :source_language, :string
    add_column :messages, :source_text, :string
    add_column :messages, :target_language, :string
    add_column :messages, :target_text, :string
    remove_column :messages, :body
  end
end
