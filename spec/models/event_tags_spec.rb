require "rails_helper"

describe EventTag, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:event_tag)).to be_valid
  end

  it "is invalid without a tag" do
    expect(FactoryGirl.build(:event_tag, tag_id: nil)).not_to be_valid
  end

  it "is invalid without an event" do
    expect(FactoryGirl.build(:event_tag, event_id: nil)).not_to be_valid
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

  it { is_expected.to belong_to :tag }
  it { is_expected.to belong_to :event }
end
