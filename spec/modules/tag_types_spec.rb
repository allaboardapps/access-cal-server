require "rails_helper"

describe TagTypes, type: :module do
  it "renders a system type" do
    expect(described_class::DEFAULT).to eq "default"
  end

  it "returns a list of system types" do
    expect(described_class.system).to include "default"
  end

  it "returns a list of consumer types" do
    expect(described_class.consumer).to include "consumer"
  end

  it "returns a list of client types" do
    expect(described_class.client).to include "client"
  end

  it "returns a list of all types" do
    expect(described_class.all).to include "default", "consumer", "client"
  end
end
