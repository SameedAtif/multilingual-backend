class TermsController < ApplicationController
  skip_before_action :authenticate_user!

  def terms_of_service; end

  def privacy_policy; end
end
