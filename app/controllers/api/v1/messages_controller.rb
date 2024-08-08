module Api
  module V1
    class MessagesController < ApplicationController
      before_action :assign_user
      before_action :assign_room

      def create
        @message = Message.create!(
          body: params["body"],
          user_id: @user.id,
          room_id: @room.id
        )
        ActionCable.server.broadcast("rooms_channel:#{@message.room.id}", @message.to_json)
      end

      private

      def assign_room
        @room = Room.find_by(id: params.dig("room_id"))
        return if @room.present?

        Room.transaction do
          @room = Room.new(
            is_private: true,
            name: "user_#{@user.id}"
          )
          @room.participants << Participant.new(room: @room, user_id: User.first.id) # replace with store owner
          @room.participants << Participant.new(room: @room, user_id: @user.id)
          @room.save!
        end
      end

      def assign_user
        @user = User.find_by(id: params.dig("user_id"))
        return if @user.present?

        @user = User.create(
          name: params["name"],
          email: "foo#{DateTime.now.to_i}@sample.com",
          password: "hello123"
        )
      end
    end
  end
end
