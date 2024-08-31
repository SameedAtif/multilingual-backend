module Api
  module V1
    class RoomsController < ApplicationController
      skip_before_action :authenticate, only: %i[create]

      before_action :assign_user
      before_action :fetch_organization

      def create
        puts "params #{params}"
        Room.transaction do
          @room = Room.new(
            is_private: true,
            name: "user_#{@user.id}",
            organization: @organization
          )
          @room.participants << Participant.new(room: @room, user_id: @organization.current_assignee_id || @organization.owner_id)
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

        @user = User.create!(
          name: params["name"],
          email: params["email"],
          user_type: :external
        )
      end

      def fetch_organization
        @organization = Organization.find_by(website: params[:org_website])
      end
    end
  end
end
