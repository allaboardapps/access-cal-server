require "rails_helper"
require "concerns/activatable_shared"

describe Occurrence, type: :model do
  it_behaves_like "activatable"

  it "has a valid factory" do
    expect(FactoryGirl.create(:occurrence)).to be_valid
  end

  it "is invalid without a starts_at date" do
    expect(FactoryGirl.build(:occurrence, starts_at: nil)).not_to be_valid
  end

  it "is invalid without an ends_at date" do
    expect(FactoryGirl.build(:occurrence, ends_at: nil)).not_to be_valid
  end

  it "is invalid without a time_zone" do
    expect(FactoryGirl.build(:occurrence, time_zone: nil)).not_to be_valid
  end

  it { is_expected.to belong_to :event }
end
