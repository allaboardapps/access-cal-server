require "rails_helper"

describe EventTag, type: :model do
  it "has a valid factory" do
    expect(create :event_tag).to be_valid
  end

  it "is invalid without a tag" do
    expect(build :event_tag, tag_id: nil).to_not be_valid
  end

  it "is invalid without an event" do
    expect(build :event_tag, event_id: nil).to_not be_valid
  end

  it { is_expected.to belong_to :tag }
  it { is_expected.to belong_to :event }
end
