class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_permitted_parameters, only: [:update]

  def new
    @site_id = params[:name]
    @website = params[:website]
    super
  end

  protected

  def update_resource(resource, params)
    if (params.keys & ["name", "email", "password", "password_confirmation"]).blank?
      resource.update(params)
    else
      super
    end
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def after_sign_up_path_for(resource)
    new_organization_path(name: params.dig(:user, :website), website: params.dig(:user, :site_id))
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :name, :email, :current_password, :password, :password_confirmation,
      :notification_conversation_assigned_email, :notification_conversation_assigned_push,
      :notification_message_received_email, :notification_message_received_push,
      :notification_message_reminder_email, :notification_message_reminder_push,
      :message_on_enter_key
    ])
  end
end
