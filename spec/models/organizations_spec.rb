require "rails_helper"

describe Organization, type: :model do
  it "has a valid factory" do
    expect(create :organization).to be_valid
  end

  it "is invalid without a name" do
    expect(build :organization, name: nil).to_not be_valid
  end

  it { is_expected.to have_many :groups }
  it { is_expected.to have_many :organization_users }
  it { is_expected.to have_many :users }
end
