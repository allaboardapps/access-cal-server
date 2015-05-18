require "rails_helper"

describe Categories, type: :module do
  it "renders a role" do
    expect(Categories::SINGLES).to eq "singles"
  end

  it "returns a list of all statuses" do
    expect(Categories.all).to include "theatre", "concert", "dance"
  end
end
