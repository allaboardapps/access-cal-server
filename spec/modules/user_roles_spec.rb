require "rails_helper"

describe UserRoles, type: :module do
  it "renders a role" do
    expect(described_class::ADMIN).to eq "admin"
  end

  it "returns a list of system roles" do
    expect(described_class.system_roles).to include "admin"
  end

  it "returns a list of client roles" do
    expect(described_class.client_roles).to include "client"
  end

  it "returns a list of consumer roles" do
    expect(described_class.consumer_roles).to include "consumer"
  end

  it "returns a list of active_admin roles" do
    expect(described_class.active_admin_roles).to include "admin"
  end

  it "returns a list of all roles" do
    expect(described_class.all).to include "admin", "consumer", "client"
  end
end
