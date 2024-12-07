class RoomsController < ApplicationController
  before_action :declare_room_variables, only: [:show, :index, :update]
  before_action :verify_subscription

  def index
    respond_to do |format|
      format.js
      format.html
    end
  end

  def show
    @other_participant_name = @room.other_participant(current_user).user.name
    @messages = @room.messages
    @room.touch(:read_at)
    @switch_tab = params[:switch_tab] == 'true'
    respond_to do |format|
      format.js
    end
  end

  def update
    @current_room = @first_room = @room = Room.find(params[:id])
    @room.update!(room_params)
    respond_to do |format|
      format.js
    end
  end

  def settings; end

  def appearance_setting; end

  private

  def verify_subscription
    subscription = current_org.owner.paddle_subscriptions.last
    is_owner = current_org.owner == current_user

    if subscription.status == "past_due" && is_owner
      redirect_to edit_user_registration_path, alert: "Please pay the pending dues before proceeding. For any issues contact support."
    elsif subscription.status == "past_due" && !is_owner
      sign_out(current_user) # Signs out the current user
      redirect_to root_path, notice: "You have been signed out. The organization has pending dues."
    end
  end

  def room_params
    params.require(:room).permit(:name, :read_at, :assignee_id, :status)
  end

  def declare_room_variables
    @rooms = current_org.rooms.joins(:messages).where(filter_params).uniq
    @room_type = (params[:room_status].presence || 'open').to_s.capitalize
    @current_room = @first_room = @room = Room.find_by(id: params[:id]) || @rooms.first
    @message = Message.new(room: @room, user: current_user)
  end

  def filter_params
    default_params = { status: (params[:room_status].presence || 'open') }
    default_params.merge!({assignee_id: current_user.id}) if params[:self_assigned].present?
    default_params.merge!({assignee_id: nil}) if params[:unassigned].present?
    default_params.merge!({read_at: nil}) if params[:unread].present?

    default_params
  end
end
