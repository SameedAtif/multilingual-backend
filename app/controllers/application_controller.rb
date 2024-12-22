class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  helper_method :current_org

  def current_org
    current_user.owned_org || current_user.organization
  end
end
