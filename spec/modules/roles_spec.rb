require "rails_helper"

describe Roles, type: :module do
  it "renders a role" do
    expect(Roles::ADMIN).to eq "admin"
  end

  it "returns a list of system roles" do
    expect(Roles.system_roles).to include "admin"
  end

  it "returns a list of client roles" do
    expect(Roles.client_roles).to include "client"
  end

  it "returns a list of customer roles" do
    expect(Roles.customer_roles).to include "customer"
  end

  it "returns a list of active_admin roles" do
    expect(Roles.active_admin_roles).to include "admin"
  end

  it "returns a list of all roles" do
    expect(Roles.all).to include "admin", "customer", "client"
  end
end
