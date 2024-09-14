class OrganizationsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :index]

  def new
    if current_user.blank?
      redirect_to new_user_registration_path(request.parameters) and return
    end
    @organization = Organization.new(name: params[:name], website: params[:website])
  end

  def create
    @organization = Organization.new(permitted_params)
    @organization.owner = current_user
    if @organization.save
      redirect_to root_path and return
    else
      render :new
    end
  end

  def update
    @organization = Organization.find(params[:id])
    @organization.update(permitted_params)
    redirect_back fallback_location: root_path
  end

  def settings; end

  private

  def permitted_params
    params.require(:organization).permit(:name, :website, :background_color, :text_color, :button_color, :icon, :label, :greeting_message)
  end
end
