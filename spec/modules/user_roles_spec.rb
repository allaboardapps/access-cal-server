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

  it "returns a list of consumer roles" do
    expect(UserRoles.consumer_roles).to include "consumer"
  end

  it "returns a list of active_admin roles" do
    expect(UserRoles.active_admin_roles).to include "admin"
  end

  it "returns a list of all roles" do
    expect(UserRoles.all).to include "admin", "consumer", "client"
  end
end
