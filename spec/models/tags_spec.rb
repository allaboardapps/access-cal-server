require "rails_helper"

describe Tag, type: :model do
  let(:tag) { FactoryGirl.create :tag }

  it "has a valid factory" do
    expect(FactoryGirl.create(:tag)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:tag, name: nil)).to_not be_valid
  end

  it "is invalid without a type" do
    expect(FactoryGirl.build(:tag, tag_type: nil)).to_not be_valid
  end

  it "requires tag names to be unique" do
    expect{
      FactoryGirl.create :tag, name: tag.name
    }.to raise_error ActiveRecord::RecordInvalid
  end

  it { is_expected.to have_many :events }
  it { is_expected.to have_many :event_tags }
end
