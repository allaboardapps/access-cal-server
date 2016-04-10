require "rails_helper"

describe Calendar, type: :model do
  let(:calendar) { FactoryGirl.create :calendar }

  it "has a valid factory" do
    expect(FactoryGirl.create(:calendar)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:calendar, name: nil)).not_to be_valid
  end

  it "is invalid without a time_zone" do
    expect(FactoryGirl.build(:calendar, time_zone: nil)).not_to be_valid
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

  describe ".actives" do
    it "only selects instances where archived and test is false" do
      FactoryGirl.create(described_class, :archived, :test)
      FactoryGirl.create(described_class, :archived)
      FactoryGirl.create(described_class, :test)
      FactoryGirl.create(described_class, test: false, archived: false)
      expect(described_class.count).to eq 4
      expect(described_class.actives.count).to eq 1
    end
  end

  describe ".archives" do
    it "only selects instances where archived is false" do
      FactoryGirl.create(described_class, :archived)
      FactoryGirl.create(described_class, :archived)
      FactoryGirl.create(described_class, archived: false)
      expect(described_class.count).to eq 3
      expect(described_class.archives.count).to eq 2
    end
  end

  describe ".tests" do
    it "only selects instances where test is false" do
      FactoryGirl.create(described_class, :test)
      FactoryGirl.create(described_class, :test)
      FactoryGirl.create(described_class, test: false)
      expect(described_class.count).to eq 3
      expect(described_class.tests.count).to eq 2
    end
  end

  describe ".dummies" do
    it "only selects instances where dummy is true" do
      FactoryGirl.create(described_class, :dummy)
      FactoryGirl.create(described_class, :dummy)
      FactoryGirl.create(described_class, dummy: false)
      expect(described_class.count).to eq 3
      expect(described_class.dummies.count).to eq 2
    end
  end

  it { is_expected.to have_many :calendar_users }
  it { is_expected.to have_many :users }
end
