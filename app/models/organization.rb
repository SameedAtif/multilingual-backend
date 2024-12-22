class Organization < ApplicationRecord
  belongs_to :owner, :class_name => 'User', dependent: :destroy

  has_many :users, dependent: :destroy
  has_many :rooms, dependent: :destroy

  has_one :current_assignee, :class_name => 'User'

  before_create :assign_client_id
  after_create_commit :create_tutorial_chat

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

  def create_tutorial_chat
    @user = User.find_or_create_by!(
      name: "Tutorial",
      email: "tutorial@example.com",
      language: "EN",
      user_type: :external,
    )
    @user.confirmed_at = DateTime.current
    @user.save!
    # Create Room
    Room.transaction do
      @room = Room.new(
        is_private: true,
        name: "user_test",
        organization: self,
        assignee_id: current_assignee_id || owner_id
      )
      @room.participants << Participant.new(room: @room, user_id: current_assignee_id || owner_id)
      @room.participants << Participant.new(room: @room, user_id: @user.id)
      @room.save!

      # Create Received Message
      @received_message = Message.create!(
        source_text: "Hello",
        user_id: @user.id,
        room_id: @room.id,
        target_text: "Hello"
      )
      # Create Sent Message
      @received_message = Message.create!(
        source_text: "Hi, How can I help you?",
        user_id: current_assignee_id || owner_id,
        room_id: @room.id,
        target_text: "Hi, How can I help you?"
      )
    end
  end
end
