require "rails_helper"

describe TagTypes, type: :module do
  it "renders a system type" do
    expect(TagTypes::DEFAULT).to eq "default"
  end

  it "returns a list of system types" do
    expect(TagTypes.system).to include "default"
  end

  it "returns a list of consumer types" do
    expect(TagTypes.consumer).to include "consumer"
  end

  it "returns a list of client types" do
    expect(TagTypes.client).to include "client"
  end

  it "returns a list of all types" do
    expect(TagTypes.all).to include "default", "consumer", "client"
  end
end
