require "rails_helper"

describe OrganizationUser, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:organization_user)).to be_valid
  end

  it "is invalid without a user" do
    expect(FactoryGirl.build(:organization_user, user_id: nil)).not_to be_valid
  end

  it "is invalid without a organization" do
    expect(FactoryGirl.build(:organization_user, organization_id: nil)).not_to be_valid
  end

  it "is invalid without a role" do
    expect(FactoryGirl.build(:organization_user, role: nil)).not_to be_valid
  end

  it { is_expected.to belong_to :organization }
  it { is_expected.to belong_to :user }
end
