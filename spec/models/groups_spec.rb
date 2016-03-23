require "rails_helper"

describe Group, type: :model do
  it "has a valid factory" do
    expect(create :group).to be_valid
  end

  it "is invalid without a name" do
    expect(build :group, name: nil).to_not be_valid
  end

  it { is_expected.to have_many :group_users }
  it { is_expected.to belong_to :organization }
  it { is_expected.to have_many :users }
end
