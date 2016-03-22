module CalendarRoles
  BILLING = "billing"
  EDITOR = "editor"
  MANAGER = "manager"
  OWNER = "owner"
  VIEWER = "viewer"

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
