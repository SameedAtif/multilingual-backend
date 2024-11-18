class UsersController < ApplicationController
  def destroy
    User.find(params[:id]).destroy
    redirect_back fallback_location: rooms_path
  end
end
