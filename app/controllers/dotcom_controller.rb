class DotcomController < ApplicationController
  skip_before_action :authenticate_user!

  def index; end

  def contact_us; end
end
