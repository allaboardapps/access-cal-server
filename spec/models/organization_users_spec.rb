require "rails_helper"

describe OrganizationUser, type: :model do
  it "has a valid factory" do
    expect(create :organization_user).to be_valid
  end

  it "is invalid without a user" do
    expect(build :organization_user, user_id: nil).to_not be_valid
  end

  it "is invalid without a organization" do
    expect(build :organization_user, organization_id: nil).to_not be_valid
  end

  it "is invalid without a role" do
    expect(build :organization_user, role: nil).to_not be_valid
  end

  it { is_expected.to belong_to :organization }
  it { is_expected.to belong_to :user }
end
