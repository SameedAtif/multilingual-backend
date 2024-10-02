class MessagesController < ApplicationController
  include ActionView::RecordIdentifier

  def create
    GenerateMessageJob.perform_async(msg_params[:room_id], current_user.id, msg_params[:source_text])
  end

  def settings; end

  private

  def msg_params
    params.require(:message).permit(:source_text, :room_id)
  end
end
