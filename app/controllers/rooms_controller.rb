class RoomsController < ApplicationController
  def index
    @rooms = current_org.rooms.joins(:messages).where(status: (params[:room_status].presence || 'open')).uniq
    @room_type = (params[:room_status].presence || 'open').to_s.capitalize
    @first_room = @rooms.first
    @message = Message.new(room: @first_room, user: current_user)
    respond_to do |format|
      format.js
      format.html
    end
  end

  def show
    @room = Room.find(params[:id])
    @other_participant_name = @room.other_participant(current_user).user.name
    @message = Message.new(room: @room, user: current_user)
    @messages = @room.messages
    @switch_tab = params[:switch_tab] == 'true'
    respond_to do |format|
      format.js
    end
  end

  def create
    @room = Room.create(name: room_params[:name])
  end

  def new
    @room = Room.joins(participants: :user)
                .group('rooms.id')
                .having('COUNT(DISTINCT participants.id) = 2')
                .where(name: params[:name], is_private: true, participants: { user_id: [current_user.id, params[:participant_id]] })
                .distinct.first
    if @room.blank?
      @room = Room.new(name: params[:name], is_private: true)
      @room.participants << Participant.new(room: @room, user_id: current_user.id)
      @room.participants << Participant.new(room: @room, user_id: params[:participant_id])
      @room.save!
    end
    @other_participant_name = User.find(params[:participant_id]).name
    # TODO: Delete rooms with no messages.
    @message = Message.new(room: @room, user: current_user)
    @messages = @room.messages
    respond_to do |format|
      format.js
    end
  end

  def room_params
    params.require(:room).permit(:name)
  end
end
