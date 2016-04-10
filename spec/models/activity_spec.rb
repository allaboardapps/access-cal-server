require "rails_helper"

describe Activity, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:activity)).to be_valid
  end

  it "is invalid without a loggable" do
    expect(FactoryGirl.build(:activity, loggable: nil)).not_to be_valid
  end

  it "is invalid without a creator" do
    expect(FactoryGirl.build(:activity, creator: nil)).not_to be_valid
  end

  describe ".create" do
    let(:creator) { FactoryGirl.create :user, :admin }
    let(:action) { ActivityActionTypes.all.sample }
    let(:description) { Faker::Lorem.sentence(10) }

    it "creates an activity log entry for change on a User instance" do
      loggable = FactoryGirl.create :user, :consumer
      described_class.log creator, loggable, action
      expect(described_class.first.loggable).to eq loggable
    end

    it "creates an activity log entry for change on a Event instance" do
      loggable = FactoryGirl.create :event
      described_class.log creator, loggable, action
      expect(described_class.first.loggable).to eq loggable
    end

    it "updates description to 'N/A' if description left blank" do
      loggable = FactoryGirl.create :event
      described_class.log creator, loggable, action
      expect(described_class.first.description).to eq "N/A"
    end

    it "updates description if provided" do
      loggable = FactoryGirl.create :event
      description = "somethin' somethin'"
      described_class.log creator, loggable, action, description
      expect(described_class.first.description).to eq description
    end

    it "requires a user to log" do
      loggable = FactoryGirl.create :admin
      described_class.log nil, loggable, action
      expect(described_class.count).to eq 0
    end

    it "requires a loggable model to log" do
      described_class.log creator, nil, action
      expect(described_class.count).to eq 0
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

  it { is_expected.to belong_to :creator }
  it { is_expected.to belong_to :loggable }
end
