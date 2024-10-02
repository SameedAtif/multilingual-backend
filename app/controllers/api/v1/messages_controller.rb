module Api
  module V1
    class MessagesController < ApplicationController
      skip_before_action :authenticate, only: %i[create]

      before_action :assign_user
      before_action :assign_room

      def create
        GenerateMessageJob.perform_async(@room.id, @user.id, params["source_text"])
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

        @user = User.find_or_create_by(
          name: params["name"],
          email: params["email"],
          language: params["language"]
        )
      end
    end
  end
end
