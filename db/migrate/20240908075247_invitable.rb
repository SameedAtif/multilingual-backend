class Invitable < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :invitation_token, :string
    add_column :users, :invitation_created_at, :datetime
    add_column :users, :invitation_sent_at, :datetime
    add_column :users, :invitation_accepted_at, :datetime
    add_column :users, :invitation_limit, :integer
    add_column :users, :invited_by_id, :integer
    add_column :users, :invited_by_type, :string
    add_index :users, :invitation_token, unique: true

    add_column :users, :notification_conversation_assigned_email, :boolean
    add_column :users, :notification_conversation_assigned_push, :boolean
    add_column :users, :notification_message_received_email, :boolean
    add_column :users, :notification_message_received_push, :boolean
    add_column :users, :notification_message_reminder_email, :boolean
    add_column :users, :notification_message_reminder_push, :boolean
    add_column :users, :message_on_enter_key, :boolean

    add_column :organizations, :background_color, :string
    add_column :organizations, :text_color, :string
    add_column :organizations, :button_color, :string
    add_column :organizations, :icon, :string
    add_column :organizations, :label, :string
    add_column :organizations, :greeting_message, :string

    create_table :notifications, id: :uuid do |t|
      t.uuid  :resource_id, null: false
      t.string  :resource_type, null: false
      t.string  :user_type, null: false
      t.belongs_to :user, foreign_key: true, type: :uuid
      t.string  :notification_type, null: false
      t.jsonb  :extra
      t.datetime  :read_at
      t.datetime  :cleared_at

      t.timestamps
    end

    add_index :notifications, [:resource_type, :resource_id]
  end
end
