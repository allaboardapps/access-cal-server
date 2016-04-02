require "rails_helper"

describe Calendar, type: :model do
  let(:calendar) { FactoryGirl.create :calendar }

  it "has a valid factory" do
    expect(create :calendar).to be_valid
  end

  it "is invalid without a name" do
    expect(build :calendar, name: nil).to_not be_valid
  end

  it "is invalid without a time_zone" do
    expect(build :calendar, time_zone: nil).to_not be_valid
  end

  describe "#archive" do
    it "updates the archived attribute to true" do
      calendar.update(archived: false)
      calendar.archive
      expect(calendar.archived).to be_truthy
    end
  end

  describe "#unarchive" do
    it "updates the archived attribute to false" do
      calendar.update(archived: true)
      calendar.unarchive
      expect(calendar.archived).to be_falsey
    end
  end

  describe "#archived?" do
    it "correctly indicates that the archived attribute is true" do
      calendar.archive
      expect(calendar.archived?).to be_truthy
    end

    it "indicates that the archived attribute is false" do
      calendar.unarchive
      expect(calendar.archived?).to be_falsey
    end
  end

  it { is_expected.to have_many :calendar_users }
  it { is_expected.to have_many :users }
end
