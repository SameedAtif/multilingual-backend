class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def new
    @site_id = params[:name]
    @website = params[:website]
    super
  end

  def create
    super
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def after_sign_up_path_for(resource)
    new_organization_path(name: params.dig(:user, :website), website: params.dig(:user, :site_id))
  end
end
