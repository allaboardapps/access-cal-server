require "rails_helper"
require "concerns/activatable_spec"

describe Location, type: :model do
  it_behaves_like "activatable"

  it "has a valid factory" do
    expect(FactoryGirl.create(:location)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:location, name: nil)).not_to be_valid
  end

  it "is invalid without an abbreviation" do
    expect(FactoryGirl.build(:location, abbreviation: nil)).not_to be_valid
  end

  it "is invalid without a region" do
    expect(FactoryGirl.build(:location, region_id: nil)).not_to be_valid
  end

  it { is_expected.to belong_to :region }
  it { is_expected.to have_many :events }
end
