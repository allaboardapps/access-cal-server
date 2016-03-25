require "rails_helper"

describe Activity, type: :model do

  it "has a valid factory" do
    expect(FactoryGirl.create :activity).to be_valid
  end

  it "is invalid without a loggable" do
    expect(FactoryGirl.build :activity, loggable: nil).to_not be_valid
  end

  it "is invalid without a creator" do
    expect(FactoryGirl.build :activity, creator: nil).to_not be_valid
  end

  describe ".create" do
    before do
      @creator = FactoryGirl.create :user, :admin
      @action = ActivityActionTypes.all.sample
      @description = Faker::Lorem.sentence(10)
    end

    it "creates an activity log entry for change on a User instance" do
      loggable = FactoryGirl.create :user, :customer
      Activity.log @creator, loggable, @action
      expect(Activity.first.loggable).to eq loggable
    end

    it "creates an activity log entry for change on a Event instance" do
      loggable = FactoryGirl.create :event
      Activity.log @creator, loggable, @action
      expect(Activity.first.loggable).to eq loggable
    end

    it "updates description to 'none' if description left blank" do
      loggable = FactoryGirl.create :event
      Activity.log @creator, loggable, @action
      expect(Activity.first.description).to be_nil
    end

    it "updates description if provided" do
      loggable = FactoryGirl.create :event
      description = "somethin' somethin'"
      Activity.log @creator, loggable, @action, description
      expect(Activity.first.description).to eq description
    end

    it "requires a user to log" do
      loggable = FactoryGirl.create :admin
      Activity.log nil, loggable, @action
      expect(Activity.count).to eq 0
    end

    it "requires a loggable model to log" do
      Activity.log @creator, nil, @action
      expect(Activity.count).to eq 0
    end
  end

  it { is_expected.to belong_to :creator }
  it { is_expected.to belong_to :loggable }
end
