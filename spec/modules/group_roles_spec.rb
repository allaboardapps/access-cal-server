require "rails_helper"

describe GroupRoles, type: :module do
  it "renders a role" do
    expect(GroupRoles::MANAGER).to eq "manager"
  end

  it "returns a list of all roles" do
    expect(GroupRoles.all).to include "owner", "manager", "viewer"
  end
end
