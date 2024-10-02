class GenerateMessageJob
  include ActionView::RecordIdentifier
  include Sidekiq::Worker

  sidekiq_options queue: :default
  sidekiq_options retry: false

  def perform(room_id, user_id, source_text)
    @message = Message.new(
      source_text: source_text,
      user_id: user_id,
      room_id: room_id
    )
    @message.target_text =  MessageInterpretationService.call(@message)
    @message.save!
    ActionCable.server.broadcast("rooms_channel:#{@message.room.id}", broadcast_payload)
  end

  private

  def broadcast_payload
    {
      message: @message.to_json,
      sender: ApplicationController.render(
        target: dom_id(@message.room, :messages),
        partial: 'messages/sent_message',
        locals: { message: @message, sender: true }
      ),
      receiver: ApplicationController.render(
        target: dom_id(@message.room, :messages),
        partial: 'messages/received_message',
        locals: { message: @message, sender: true }
      ),
      sender_id: @message.user.id
    }
  end
end
