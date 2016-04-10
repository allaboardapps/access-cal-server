module EventRoles
  BILLING = "billing".freeze
  EDITOR = "editor".freeze
  MANAGER = "manager".freeze
  OWNER = "owner".freeze
  VIEWER = "viewer".freeze

  def self.all
    [
      EventRoles::OWNER,
      EventRoles::BILLING,
      EventRoles::MANAGER,
      EventRoles::EDITOR,
      EventRoles::VIEWER
    ]
  end
end
