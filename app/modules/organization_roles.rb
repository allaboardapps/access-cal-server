module OrganizationRoles
  BILLING = "billing".freeze
  EDITOR = "editor".freeze
  MANAGER = "manager".freeze
  OWNER = "owner".freeze
  VIEWER = "viewer".freeze

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
