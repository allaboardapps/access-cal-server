require "rails_helper"

describe Region, type: :model do
  it "has a valid factory" do
    expect(create :region).to be_valid
  end

  it "is invalid without a name" do
    expect(build :region, name: nil).to_not be_valid
  end

  it "is invalid without an abbreviation" do
    expect(build :region, abbreviation: nil).to_not be_valid
  end

  it { is_expected.to have_many :locations }
  it { is_expected.to have_many :events }
end
