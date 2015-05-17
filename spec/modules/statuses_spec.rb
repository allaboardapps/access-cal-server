require "rails_helper"

describe Statuses, type: :module do
  it "renders a role" do
    expect(Statuses::PRO).to eq "pro"
  end

  it "returns a list of all statuses" do
    expect(Statuses.all).to include "basic", "pro", "premium"
  end
end
