class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  # has_many_attached :attachments, dependent: :destroy

  validate :confirm_participant

  after_create :notify_organization

  def chat_attachment(index)
    target = attachments[index]
    return unless attachments.attached?
    target
  end

  private

  def confirm_participant
    has_participant = Participant.find_by(user_id: self.user.id, room_id: self.room.id)
    errors.add(:base, "Participant is required") unless has_participant
  end

  def notify_organization
    Notification.create!(
      resource_id: id,
      resource_type: self.class.name,
      user_type: user.user_type,
      user_id: user_id,
      notification_type: Notification::NOTIFICATION_TYPES_MAP[:new_message]
    )
  end
end
