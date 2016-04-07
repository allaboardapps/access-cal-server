require "rails_helper"

describe Categories, type: :module do
  it "renders a role" do
    expect(described_class::SINGLES).to eq "singles"
  end

  it "returns a list of all statuses" do
    expect(described_class.all).to include "theatre", "concert", "dance"
  end
end
