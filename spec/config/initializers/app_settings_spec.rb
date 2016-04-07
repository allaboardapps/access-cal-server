require_relative "../../rails_helper"

describe AppSettings, type: :class do
  it "will retrieve the app name" do
    expect(described_class.app_name).to eq("Access Cal Server")
  end

  it "will not retrieve the wrong app name" do
    expect(described_class.app_name).not_to eq("Something Else")
  end
end
