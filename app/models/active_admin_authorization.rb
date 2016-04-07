class ActiveAdminAuthorization < ActiveAdmin::AuthorizationAdapter
  def authorized?(_action, _subject = nil)
    user.active_admin_access?
  end
end
