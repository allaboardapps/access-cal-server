require "rails_helper"
require "concerns/activatable_shared"

describe Event, type: :model do
  it_behaves_like "activatable"

  let(:event) { FactoryGirl.create :event }

  it "has a valid factory" do
    expect(FactoryGirl.create(:event)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:event, name: nil)).not_to be_valid
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
        event.touch
        sleep 3
        described_class.__elasticsearch__.refresh_index!
      end

      it "will complete a search by event name" do
        response = described_class.search_for(event.name)
        expect(response.results.total).to eq 1
      end

      it "will complete a search by event abbreviation" do
        response = described_class.search_for(event.abbreviation)
        expect(response.results.total).to eq 1
      end

      it "will complete a search by tag name after an event tag association is created" do
        tag = FactoryGirl.create :tag
        FactoryGirl.create :event_tag, tag: tag, event: event
        described_class.__elasticsearch__.refresh_index!
        response = described_class.search_for(tag.name)
        expect(response.results.total).to eq 1
      end

      it "will not complete a search by tag name after an event tag association is deleted" do
        tag_name = "closed-captioned"
        tag = FactoryGirl.create :tag, name: tag_name
        event_tag = FactoryGirl.create :event_tag, tag: tag, event: event
        event_tag.destroy
        described_class.__elasticsearch__.refresh_index!
        response = described_class.search_for(tag_name)
        expect(response.results.total).to eq 0
      end
    end
  end

  describe "versioning" do
    before do
      event.touch
      event.update(name: "New Event Name_1", zip_code: "31522")
      event.update(name: "New Event Name_2")
      event.update(name: "New Event Name_3")
    end

    it "versions changes to the model", versioning: true do
      expect(event.versions.count).to eq(4)
    end

    it "versions changes to the model", versioning: true do
      expect(event.versions.last.reify.name).to eq("New Event Name_2")
    end

    it "tracks the last version action on the model", versioning: true do
      expect(event.versions.last.event).to eq("update")
    end

    it "verifies the live version of the model", versioning: true do
      expect(event.live?).to be_truthy
    end

    it "verifies a non-live version of the model", versioning: true do
      prev_version = event.previous_version
      expect(prev_version.live?).to be_falsey
    end

    it "returns the changeset of the model", versioning: true do
      expect(event.versions.last.changeset["name"].count).to eq 2
      expect(event.versions.last.changeset["name"]).to include "New Event Name_2", "New Event Name_3"
      expect(event.versions.last.changeset["updated_at"].count).to eq 2
    end
  end

  it { is_expected.to belong_to :author }
  it { is_expected.to belong_to :calendar }
  it { is_expected.to belong_to :location }
  it { is_expected.to have_many :activities }
  it { is_expected.to have_many :event_tags }
  it { is_expected.to have_many :event_users }
  it { is_expected.to have_many :favorite_users }
  it { is_expected.to have_many :favorites }
  it { is_expected.to have_many :occurrences }
  it { is_expected.to have_many :tags }
  it { is_expected.to have_many :users }
  it { is_expected.to have_one :region }
end
