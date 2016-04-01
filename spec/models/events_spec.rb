require "rails_helper"

describe Event, type: :model do
  let(:event) { FactoryGirl.create :event }

  it "has a valid factory" do
    expect(create :event).to be_valid
  end

  it "is invalid without a name" do
    expect(build :event, name: nil).to_not be_valid
  end

  xit "is invalid without an abbreviation" do
    expect(build :event, abbreviation: nil).to_not be_valid
  end

  xit "is invalid without a primary category" do
    expect(build :event, primary_category: nil).to_not be_valid
  end

  describe "#archive" do
    it "updates the archived attribute to true" do
      event.update(archived: false)
      event.archive
      expect(event.archived).to be_truthy
    end
  end

  describe "#unarchive" do
    it "updates the archived attribute to false" do
      event.update(archived: true)
      event.unarchive
      expect(event.archived).to be_falsey
    end
  end

  describe "#archived?" do
    it "correctly indicates that the archived attribute is true" do
      event.archive
      expect(event.archived?).to be_truthy
    end

    it "indicates that the archived attribute is false" do
      event.unarchive
      expect(event.archived?).to be_falsey
    end
  end

  it { is_expected.to belong_to :author }
  it { is_expected.to belong_to :location }
  it { is_expected.to have_many :activities }
  it { is_expected.to have_many :favorites }
  it { is_expected.to have_many :users }
  it { is_expected.to have_one :region }
end
