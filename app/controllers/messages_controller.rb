class MessagesController < ApplicationController
  include ActionView::RecordIdentifier

  def create
    @message = current_user.messages.create!(
      source_text: msg_params[:source_text],
      room_id: msg_params[:room_id]
    )
    ActionCable.server.broadcast("rooms_channel:#{@message.room.id}", broadcast_payload)
  end

  private

  def msg_params
    params.require(:message).permit(:source_text, :room_id)
  end

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
