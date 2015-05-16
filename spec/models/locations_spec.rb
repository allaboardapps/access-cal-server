require "rails_helper"

describe Location, type: :model do
  it "has a valid factory" do
    expect(create :location).to be_valid
  end

  it "is invalid without a name" do
    expect(build :location, name: nil).to_not be_valid
  end

  it "is invalid without an abbreviation" do
    expect(build :location, abbreviation: nil).to_not be_valid
  end

  it "is invalid without a region" do
    expect(build :location, region_id: nil).to_not be_valid
  end

  it { is_expected.to belong_to :region }
  it { is_expected.to have_many :events }
end
