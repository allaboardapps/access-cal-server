module GroupRoles
  BILLING = "billing"
  EDITOR = "editor"
  MANAGER = "manager"
  OWNER = "owner"
  VIEWER = "viewer"

  def self.all
    [
      GroupRoles::OWNER,
      GroupRoles::BILLING,
      GroupRoles::MANAGER,
      GroupRoles::EDITOR,
      GroupRoles::VIEWER
    ]
  end
end
