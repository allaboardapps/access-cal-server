module OrganizationRoles
  BILLING = "billing"
  EDITOR = "editor"
  MANAGER = "manager"
  OWNER = "owner"
  VIEWER = "viewer"

  def self.all
    [
      OrganizationRoles::OWNER,
      OrganizationRoles::BILLING,
      OrganizationRoles::MANAGER,
      OrganizationRoles::EDITOR,
      OrganizationRoles::VIEWER
    ]
  end
end
