module GroupRoles
  BILLING = "billing".freeze
  EDITOR = "editor".freeze
  MANAGER = "manager".freeze
  OWNER = "owner".freeze
  VIEWER = "viewer".freeze

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
