class Organization < ApplicationRecord
  belongs_to :owner, :class_name => 'User'

  has_many :users
  has_many :rooms

  has_one :current_assignee, :class_name => 'User'

  before_create :assign_client_id

  VALID_ICONS = {
    message_square_more: 'Message',
    message_circle_question: 'Question',
  }.freeze

  VALID_LABELS = {
    chat: 'Chat',
    help: 'Help',
    admin: 'Admin',
    support: 'Support'
  }.freeze

  private

  def assign_client_id
    return if client_id.present?

    self.client_id = SecureRandom.hex(32)
  end
end
