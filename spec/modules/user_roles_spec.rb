require "rails_helper"

describe UserRoles, type: :module do
  it "renders a role" do
    expect(UserRoles::ADMIN).to eq "admin"
  end

  it "returns a list of system roles" do
    expect(UserRoles.system_roles).to include "admin"
  end

  it "returns a list of client roles" do
    expect(UserRoles.client_roles).to include "client"
  end

  it "returns a list of customer roles" do
    expect(UserRoles.customer_roles).to include "customer"
  end

  it "returns a list of active_admin roles" do
    expect(UserRoles.active_admin_roles).to include "admin"
  end

  it "returns a list of all roles" do
    expect(UserRoles.all).to include "admin", "customer", "client"
  end
end
