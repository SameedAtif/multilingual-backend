class RoomsChannel < ApplicationCable::Channel
  def subscribed
    @room = Room.find(params[:room])
    stream_from "rooms_channel:#{params[:room]}"
  end
end
