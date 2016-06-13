class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session, if: proc { |c| c.request.format == "application/json" }

  def authorized_for_active_admin?
    current_user.admin?
  end

  def access_denied(error)
    render nothing: true, status: :access_denied
  end
end
