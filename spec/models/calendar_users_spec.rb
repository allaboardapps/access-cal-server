require "rails_helper"

describe CalendarUser, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:calendar_user)).to be_valid
  end

  it "is invalid without a user" do
    expect(FactoryGirl.build(:calendar_user, user_id: nil)).to_not be_valid
  end

  it "is invalid without a calendar" do
    expect(FactoryGirl.build(:calendar_user, calendar_id: nil)).to_not be_valid
  end

  it "is invalid without a role" do
    expect(FactoryGirl.build(:calendar_user, role: nil)).to_not be_valid
  end

  it { is_expected.to belong_to :calendar }
  it { is_expected.to belong_to :user }
end
