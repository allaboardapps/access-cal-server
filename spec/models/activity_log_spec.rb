require "rails_helper"

describe ActivityLog, type: :model do

  it "has a valid factory" do
    expect(FactoryGirl.create :activity_log).to be_valid
  end

  it "is invalid without a loggable" do
    expect(FactoryGirl.build :activity_log, loggable: nil).to_not be_valid
  end

  it "is invalid without a creator" do
    expect(FactoryGirl.build :activity_log, creator: nil).to_not be_valid
  end

  describe ".create" do
    before do
      @creator = FactoryGirl.create :user, :admin
      @action = ActivityActionTypes.all.sample
      @description = Faker::Lorem.sentence(10)
    end

    it "creates an activity log entry for change on a User instance" do
      loggable = FactoryGirl.create :user, :customer
      ActivityLog.execute @creator, loggable, @action
      expect(ActivityLog.first.loggable).to eq loggable
    end

    it "creates an activity log entry for change on a Event instance" do
      loggable = FactoryGirl.create :event
      ActivityLog.execute @creator, loggable, @action
      expect(ActivityLog.first.loggable).to eq loggable
    end

    it "requires a user to log" do
      loggable = FactoryGirl.create :admin
      ActivityLog.execute nil, loggable, @action
      expect(ActivityLog.count).to eq 0
    end

    it "requires a loggable model to log" do
      ActivityLog.execute @creator, nil, @action
      expect(ActivityLog.count).to eq 0
    end
  end

  it { is_expected.to belong_to :creator }
  it { is_expected.to belong_to :loggable }
end
