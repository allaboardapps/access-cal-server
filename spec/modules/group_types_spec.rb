require "rails_helper"

describe GroupTypes, type: :module do
  it "renders a role" do
    expect(described_class::MANAGERS).to eq "managers"
  end

  it "returns a list of all roles" do
    expect(described_class.all).to include "owners", "managers", "viewers"
  end
end
