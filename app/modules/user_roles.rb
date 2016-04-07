module UserRoles
  ADMIN = "admin".freeze
  STAFF = "staff".freeze
  CLIENT = "client".freeze
  CONSUMER = "consumer".freeze

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
    self.system_roles.concat(self.client_roles).concat(self.consumer_roles).concat(self.active_admin_roles).sort
  end
end
