module Roles
  USER = "user"
  ADMIN = "admin"
  CLIENT = "staff"

  def self.system_roles
    [Roles::ADMIN]
  end

  def self.client_roles
    [Roles::CLIENT]
  end

  def self.user_roles
    [Roles::USER]
  end

  def self.active_admin_roles
    [Roles::ADMIN]
  end

  def self.all_roles
    self.system_roles.concat(self.support_roles).concat(self.client_roles).concat(self.tutor_roles).concat(self.active_admin_roles).sort
  end
end
