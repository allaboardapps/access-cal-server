require "rails_helper"

describe UserStatuses, type: :module do
  it "renders a role" do
    expect(UserStatuses::PRO).to eq "pro"
  end

  it "returns a list of all statuses" do
    expect(UserStatuses.all).to include "basic", "not applicable", "pro", "premium"
  end
end
