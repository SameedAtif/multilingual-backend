module Api
  module V1
    class OrganizationsController < ApplicationController
      skip_before_action :authenticate, only: %i[show]

      def show
        @org = Organization.find_by!(website: params[:website])
        render json: {
          background_color:  @org.background_color,
          text_color: @org.text_color,
          button_color: @org.button_color,
          icon: @org.icon,
          label: @org.label
        }, status: :ok
      end
    end
  end
end
