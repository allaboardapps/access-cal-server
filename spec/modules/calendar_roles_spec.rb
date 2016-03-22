require "rails_helper"

describe CalendarRoles, type: :module do
  it "renders a role" do
    expect(CalendarRoles::MANAGER).to eq "manager"
  end

  it "returns a list of all roles" do
    expect(CalendarRoles.all).to include "owner", "manager", "viewer"
  end
end
