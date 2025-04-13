class DotcomController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :redirect_if_authenticated

  def index; end

  def contact_us; end

  def features; end

  private

  def redirect_if_authenticated
    redirect_to rooms_path and return if current_user.present?
  end
end
