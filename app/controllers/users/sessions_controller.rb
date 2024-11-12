class Users::SessionsController < Devise::SessionsController
  protected

  def after_sign_in_path_for(resource)
    return root_url if (current_user.owned_org || current_user.organization).present?

    new_organization_path
  end
end
