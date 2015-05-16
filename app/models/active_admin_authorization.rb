class ActiveAdminAuthorization < ActiveAdmin::AuthorizationAdapter

  def authorized?(action, subject = nil)
    user.active_admin_access?
  end

end
