class OrganizationsController < ApplicationController
  include ActionController::Live

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

  def index
  end

  private

  def permitted_params
    params.require(:organization).permit(:name, :website)
  end
end
