class Room < ApplicationRecord
  belongs_to :organization
  belongs_to :assignee, :class_name => 'User'

  has_many :messages, dependent: :destroy
  has_many :participants, dependent: :destroy

  scope :public_rooms, -> { where(is_private: false) }

  enum status: {
    open: 0, # We have a password for them
    closed: 1 # Shopify user, guest user (we don't have a password for them)
  }

  def participant?(room, user)
    room.participants.where(user: user).any?
  end

  def self.get_name(user)
    "private_#{user.id}"
  end

  def add_user(user)
    participants.find_or_create_by!(user_id: user.id)
  end

  def remove_user(user)
    participants&.find_by(user_id: user.id).destroy
  end

  def other_participant(user)
    participants.where.not(user: user).first
  end
end
