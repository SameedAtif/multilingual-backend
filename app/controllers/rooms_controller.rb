class RoomsController < ApplicationController
  before_action :declare_room_variiables, only: [:show, :index, :update]

  def index
    respond_to do |format|
      format.js
      format.html
    end
  end

  def show
    @other_participant_name = @room.other_participant(current_user).user.name
    @messages = @room.messages
    @switch_tab = params[:switch_tab] == 'true'
    respond_to do |format|
      format.js
    end
  end

  def update
    @current_room = @first_room = @room = Room.find(params[:id])
    debugger
    @room.update!(room_params)
    respond_to do |format|
      format.js
    end
  end

  def settings; end

  def appearance_setting; end

  private

  def room_params
    params.require(:room).permit(:name, :read_at, :assignee_id, :status)
  end

  def declare_room_variiables
    @rooms = current_org.rooms.joins(:messages).where(status: (params[:room_status].presence || 'open')).uniq
    @room_type = (params[:room_status].presence || 'open').to_s.capitalize
    @current_room = @first_room = @room = Room.find_by(id: params[:id]) || @rooms.first
    @message = Message.new(room: @room, user: current_user)
  end
end
