module CalendarRoles
  BILLING = "billing".freeze
  EDITOR = "editor".freeze
  MANAGER = "manager".freeze
  OWNER = "owner".freeze
  VIEWER = "viewer".freeze

  def self.all
    [
      CalendarRoles::OWNER,
      CalendarRoles::BILLING,
      CalendarRoles::MANAGER,
      CalendarRoles::EDITOR,
      CalendarRoles::VIEWER
    ]
  end
end
