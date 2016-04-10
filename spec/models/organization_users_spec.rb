require "rails_helper"

describe OrganizationUser, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:organization_user)).to be_valid
  end

  it "is invalid without a user" do
    expect(FactoryGirl.build(:organization_user, user_id: nil)).not_to be_valid
  end

  it "is invalid without a organization" do
    expect(FactoryGirl.build(:organization_user, organization_id: nil)).not_to be_valid
  end

  it "is invalid without a role" do
    expect(FactoryGirl.build(:organization_user, role: nil)).not_to be_valid
  end

  describe ".actives" do
    it "only selects instances where archived and test is false" do
      FactoryGirl.create(described_class.name.underscore.to_sym, :archived, :test)
      FactoryGirl.create(described_class.name.underscore.to_sym, :archived)
      FactoryGirl.create(described_class.name.underscore.to_sym, :test)
      FactoryGirl.create(described_class.name.underscore.to_sym, test: false, archived: false)
      expect(described_class.count).to eq 4
      expect(described_class.actives.count).to eq 1
    end
  end

  describe ".archives" do
    it "only selects instances where archived is false" do
      FactoryGirl.create(described_class.name.underscore.to_sym, :archived)
      FactoryGirl.create(described_class.name.underscore.to_sym, :archived)
      FactoryGirl.create(described_class.name.underscore.to_sym, archived: false)
      expect(described_class.count).to eq 3
      expect(described_class.archives.count).to eq 2
    end
  end

  describe ".tests" do
    it "only selects instances where test is false" do
      FactoryGirl.create(described_class.name.underscore.to_sym, :test)
      FactoryGirl.create(described_class.name.underscore.to_sym, :test)
      FactoryGirl.create(described_class.name.underscore.to_sym, test: false)
      expect(described_class.count).to eq 3
      expect(described_class.tests.count).to eq 2
    end
  end

  describe ".dummies" do
    it "only selects instances where dummy is true" do
      FactoryGirl.create(described_class.name.underscore.to_sym, :dummy)
      FactoryGirl.create(described_class.name.underscore.to_sym, :dummy)
      FactoryGirl.create(described_class.name.underscore.to_sym, dummy: false)
      expect(described_class.count).to eq 3
      expect(described_class.dummies.count).to eq 2
    end
  end

  it { is_expected.to belong_to :organization }
  it { is_expected.to belong_to :user }
end
