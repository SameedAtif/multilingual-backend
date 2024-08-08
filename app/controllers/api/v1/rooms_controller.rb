module Api
  module V1
    class RoomsController < ApplicationController
      before_action :assign_user

      def create
        puts "params #{params}"
        Room.transaction do
          @room = Room.new(
            is_private: true,
            name: "user_#{@user.id}"
          )
          @room.participants << Participant.new(room: @room, user_id: User.first.id) # replace with store owner
          @room.participants << Participant.new(room: @room, user_id: @user.id)
          @room.save!
          render json: { message: 'Logged in successfully', room_id:  @room.id, user_id: @user.id }, status: :ok
        end
      end

      def show; end

      private

      def assign_user
        @user = User.find_by(id: params.dig("user_id"))
        return if @user.present?

        @user = User.create(
          name: params["name"],
          email: params["email"],
          password: "hello123"
        )
      end
    end
  end
end
