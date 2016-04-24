require "rails_helper"
require "concerns/activatable_shared"

describe Group, type: :model do
  it_behaves_like "activatable"

  it_behaves_like "activatable"

  it "has a valid factory" do
    expect(FactoryGirl.create(:group)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:group, name: nil)).not_to be_valid
  end

  it { is_expected.to have_many :group_users }
  it { is_expected.to belong_to :organization }
  it { is_expected.to have_many :users }
end
