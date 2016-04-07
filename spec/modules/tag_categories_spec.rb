require "rails_helper"

describe TagCategories, type: :module do
  it "renders a category type" do
    expect(described_class::ACCESSIBILITY).to eq "accessibility"
  end

  it "returns a list of all types" do
    expect(described_class.all).to include "accessibility", "assembly", "content"
  end
end
