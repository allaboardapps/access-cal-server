require "rails_helper"

describe Calendar, type: :model do
  it "has a valid factory" do
    expect(create :calendar).to be_valid
  end

  it "is invalid without a name" do
    expect(build :calendar, name: nil).to_not be_valid
  end

  it { is_expected.to have_many :users }
end
