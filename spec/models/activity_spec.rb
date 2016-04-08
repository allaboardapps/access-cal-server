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

  it { is_expected.to belong_to :creator }
  it { is_expected.to belong_to :loggable }
end
