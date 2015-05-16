module Roles
  CUSTOMER = "customer"
  ADMIN = "admin"
  CLIENT = "client"

  def self.system_roles
    [Roles::ADMIN]
  end

  def self.client_roles
    [Roles::CLIENT]
  end

  def self.customer_roles
    [Roles::CUSTOMER]
  end

  def self.active_admin_roles
    [Roles::ADMIN]
  end

  def self.all
    self.system_roles.concat(self.client_roles).concat(self.customer_roles).concat(self.active_admin_roles).sort
  end
end
