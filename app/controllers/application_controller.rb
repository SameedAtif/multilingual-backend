class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def current_org
    current_user.owned_org || current_user.organization
  end
end
