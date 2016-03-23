require "rails_helper"

describe GroupTypes, type: :module do
  it "renders a role" do
    expect(GroupTypes::MANAGERS).to eq "managers"
  end

  it "returns a list of all roles" do
    expect(GroupTypes.all).to include "owners", "managers", "viewers"
  end
end
