require "rails_helper"
require "concerns/activatable_shared"

describe Organization, type: :model do
  it_behaves_like "activatable"

  it "has a valid factory" do
    expect(FactoryGirl.create(:organization)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:organization, name: nil)).not_to be_valid
  end

  it { is_expected.to have_many :groups }
  it { is_expected.to have_many :organization_users }
  it { is_expected.to have_many :users }
end
