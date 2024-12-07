class Users::InvitationsController < Devise::InvitationsController
  private

  # Permit the new params here.
  def invite_params
    params.require(:invite).permit(:email,:name, :organization_id)
  end
end
