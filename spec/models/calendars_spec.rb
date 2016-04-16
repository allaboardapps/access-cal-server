require "rails_helper"
require "concerns/activatable_spec"

describe Calendar, type: :model do
  it_behaves_like "activatable"

  let(:calendar) { FactoryGirl.create :calendar }

  it "has a valid factory" do
    expect(FactoryGirl.create(:calendar)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:calendar, name: nil)).not_to be_valid
  end

  it "is invalid without a time_zone" do
    expect(FactoryGirl.build(:calendar, time_zone: nil)).not_to be_valid
  end

  it { is_expected.to have_many :calendar_users }
  it { is_expected.to have_many :events }
  it { is_expected.to have_many :users }
end
