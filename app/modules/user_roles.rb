module UserRoles
  ADMIN = "admin"
  STAFF = "staff"
  CLIENT = "client"
  CONSUMER = "consumer"

  def self.system_roles
    [UserRoles::ADMIN, UserRoles::STAFF]
  end

  def self.client_roles
    [UserRoles::CLIENT]
  end

  def self.consumer_roles
    [UserRoles::CONSUMER]
  end

  def self.active_admin_roles
    [UserRoles::ADMIN]
  end

  def self.all
    self.system_roles.concat(self.client_roles).concat(self.customer_roles).concat(self.active_admin_roles).sort
  end
end
