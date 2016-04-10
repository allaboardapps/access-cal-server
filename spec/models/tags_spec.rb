require "rails_helper"

describe Tag, type: :model do
  let(:tag) { FactoryGirl.create :tag }

  it "has a valid factory" do
    expect(FactoryGirl.create(:tag)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:tag, name: nil)).not_to be_valid
  end

  it "is invalid without a type" do
    expect(FactoryGirl.build(:tag, tag_type: nil)).not_to be_valid
  end

  it "requires tag names to be unique" do
    expect { FactoryGirl.create :tag, name: tag.name }.to raise_error ActiveRecord::RecordInvalid
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

  it { is_expected.to have_many :events }
  it { is_expected.to have_many :event_tags }
end
