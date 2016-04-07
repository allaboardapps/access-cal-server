require "rails_helper"

describe Event, type: :model do
  let(:event) { FactoryGirl.create :event }

  it "has a valid factory" do
    expect(FactoryGirl.create(:event)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:event, name: nil)).to_not be_valid
  end

  it "is invalid without a time_zone" do
    expect(FactoryGirl.build(:event, time_zone: nil)).to_not be_valid
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

  describe "Searching for an event" do
    context "using elasticsearch", elasticsearch: true, commit: true do
      before do
        @event = FactoryGirl.create(:event)
        sleep 3
      end

      it "should complete a search by event name" do
        response = Event.search_for(@event.name)
        expect(response.results.total).to eq 1
      end

      it "should complete a search by event abbreviation" do
        response = Event.search_for(@event.abbreviation)
        expect(response.results.total).to eq 1
      end

      it "should complete a search by tag name after an event tag association is created" do
        tag = FactoryGirl.create :tag
        FactoryGirl.create :event_tag, tag: tag, event: @event
        sleep 3
        response = Event.search_for(tag.name)
        expect(response.results.total).to eq 1
      end

      it "should not complete a search by tag name after an event tag association is deleted" do
        tag = FactoryGirl.create :tag
        event_tag = FactoryGirl.create :event_tag, tag: tag, event: @event
        event_tag.destroy
        sleep 3
        response = Event.search_for(tag.name)
        expect(response.results.total).to eq 0
      end
    end
  end

  it { is_expected.to belong_to :author }
  it { is_expected.to belong_to :location }
  it { is_expected.to have_many :activities }
  it { is_expected.to have_many :event_tags }
  it { is_expected.to have_many :favorites }
  it { is_expected.to have_many :tags }
  it { is_expected.to have_many :users }
  it { is_expected.to have_one :region }
end
