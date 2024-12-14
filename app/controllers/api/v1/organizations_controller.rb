module Api
  module V1
    class OrganizationsController < ApplicationController
      skip_before_action :authenticate, only: %i[show]

      def show
        @org = Organization.find_by!(website: params[:website], client_id: params[:client_id])
        render json: {
          name: @org.name,
          background_color:  @org.background_color,
          text_color: @org.text_color,
          button_color: @org.button_color,
          icon: @org.icon,
          label: Organization::VALID_LABELS[@org.label.to_sym],
          greeting_message: @org.greeting_message
        }, status: :ok
      end
    end
  end
end
