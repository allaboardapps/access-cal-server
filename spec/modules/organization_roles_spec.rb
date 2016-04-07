require "rails_helper"

describe OrganizationRoles, type: :module do
  it "renders a role" do
    expect(described_class::MANAGER).to eq "manager"
  end

  it "returns a list of all roles" do
    expect(described_class.all).to include "owner", "manager", "viewer"
  end
end
