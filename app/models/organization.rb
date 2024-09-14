class Organization < ApplicationRecord
  belongs_to :owner, :class_name => 'User'

  has_many :users
  has_many :rooms

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
end
