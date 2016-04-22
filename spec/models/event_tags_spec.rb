require "rails_helper"
require "concerns/activatable_shared"

describe EventTag, type: :model do
  it_behaves_like "activatable"

  it "has a valid factory" do
    expect(FactoryGirl.create(:event_tag)).to be_valid
  end

  it "is invalid without a tag" do
    expect(FactoryGirl.build(:event_tag, tag_id: nil)).not_to be_valid
  end

  it "is invalid without an event" do
    expect(FactoryGirl.build(:event_tag, event_id: nil)).not_to be_valid
  end

  it { is_expected.to belong_to :tag }
  it { is_expected.to belong_to :event }
end
