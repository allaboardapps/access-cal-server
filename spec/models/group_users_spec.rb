require "rails_helper"

describe GroupUser, type: :model do
  it "has a valid factory" do
    expect(create :group_user).to be_valid
  end

  it "is invalid without a user" do
    expect(build :group_user, user_id: nil).to_not be_valid
  end

  it "is invalid without a group" do
    expect(build :group_user, group_id: nil).to_not be_valid
  end

  it "is invalid without a role" do
    expect(build :group_user, role: nil).to_not be_valid
  end

  it { is_expected.to belong_to :group }
  it { is_expected.to belong_to :user }
end
