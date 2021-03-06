require "rails_helper"
require "concerns/activatable_shared"

describe Region, type: :model do
  it_behaves_like "activatable"

  it "has a valid factory" do
    expect(FactoryGirl.create(:region)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:region, name: nil)).not_to be_valid
  end

  it "is invalid without an abbreviation" do
    expect(FactoryGirl.build(:region, abbreviation: nil)).not_to be_valid
  end

  it { is_expected.to have_many :locations }
  it { is_expected.to have_many :events }
end
