class Notification < ApplicationRecord
  include EmailHandler

  belongs_to :resource, polymorphic: true, optional: true
  belongs_to :user

  self.inheritance_column = :_type_disabled

  after_create_commit -> {
    broadcast_append_later_to(
      "notifications_channel:#{user.id}",
      target: "notifications",
      partial: 'notifications/invitation_notification',
      locals: { notification: self }
    )
  }

  NOTIFICATION_TYPES_MAP = {
    new_organization: 'new_organization',
    new_message: 'new_message',
  }
  NOTIFICATION_TYPES = NOTIFICATION_TYPES_MAP.values

  validates :notification_type, inclusion: { in: NOTIFICATION_TYPES }
  validates :notification_type, :resource_type, :resource_id, :user_id, presence: true
end

