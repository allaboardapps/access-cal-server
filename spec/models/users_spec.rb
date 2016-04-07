require "rails_helper"

describe User, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:user)).to be_valid
  end

  it "is invalid without an email address" do
    expect(FactoryGirl.build(:user, password: nil)).to_not be_valid
  end

  it "is invalid without a password" do
    expect(FactoryGirl.build(:user, email: nil)).to_not be_valid
  end

  it "is invalid without a sufficient password" do
    expect(FactoryGirl.build(:user, password: "1234567")).to_not be_valid
  end

  it "is invalid without a time zone" do
    expect(FactoryGirl.build(:user, time_zone: nil)).to_not be_valid
  end

  describe "#full_name" do
    it "renders the user first and last name separated by a space" do
      user = FactoryGirl.create(:user, first_name: "Bubba", last_name: "Jones")
      expect(user.full_name).to eq "#{user.first_name.capitalize} #{user.last_name.capitalize}"
    end

    it "capitalizes the user first and last names" do
      user = FactoryGirl.create(:user, first_name: "bubba", last_name: "jones")
      expect(user.full_name).to eq "#{user.first_name.capitalize} #{user.last_name.capitalize}"
    end

    it "capitalizes the user first name and trims any pre-fixed space" do
      user = FactoryGirl.create(:user, first_name: "bubba", last_name: "")
      expect(user.full_name).to eq user.first_name.capitalize
    end

    it "capitalizes the user last name and trims any post-fixed space" do
      user = FactoryGirl.create(:user, first_name: "", last_name: "jones")
      expect(user.full_name).to eq user.last_name.capitalize
    end

    context "nil names" do
      it "capitalizes the user last name and trims any post-fixed space" do
        user = FactoryGirl.create(:user, first_name: nil, last_name: "jones")
        expect(user.full_name).to eq user.last_name.capitalize
      end

      it "capitalizes the user first name and trims any post-fixed space" do
        user = FactoryGirl.create(:user, first_name: "bubba", last_name: nil)
        expect(user.full_name).to eq user.first_name.capitalize
      end

      it "returns a blank" do
        user = FactoryGirl.create(:user, first_name: nil, last_name: nil)
        expect(user.full_name).to eq ""
      end
    end

    describe "#first_name_abbreviated" do
      it "renders the user first name abbreviated with period, last name by seven characters" do
        user = FactoryGirl.create(:user, first_name: "Bubba", last_name: "Schemmel")
        expect(user.first_name_abbreviated).to eq "B. Schemme"
      end

      it "renders the user first name abbreviated with period, last name by seven or less chars" do
        user = FactoryGirl.create(:user, first_name: "Mark", last_name: "Smith")
        expect(user.first_name_abbreviated).to eq "M. Smith"
      end

      it "renders the user first abbreviated by a single character and last name by argument" do
        user = FactoryGirl.create(:user, first_name: "Bubba", last_name: "Jones-Smitherwich")
        expect(user.first_name_abbreviated(10)).to eq "B. Jones-Smit"
      end
    end

    describe "#last_name_abbreviated" do
      it "renders the user first name by seven characters, last name abbreviated with period" do
        user = FactoryGirl.create(:user, first_name: "Bubbalicious", last_name: "Schemmel")
        expect(user.last_name_abbreviated).to eq "Bubbali S."
      end

      it "renders the user first name by seven or less chars, last name abbreviated with period" do
        user = FactoryGirl.create(:user, first_name: "Mark", last_name: "Smith")
        expect(user.last_name_abbreviated).to eq "Mark S."
      end

      it "renders the user first abbreviated by a single character and last name by argument" do
        user = FactoryGirl.create(:user, first_name: "Bubbalicious", last_name: "Jones-Smitherwich")
        expect(user.last_name_abbreviated(14)).to eq "Bubbalicious J."
      end
    end

    describe "#admin?" do
      it "returns true if user has a role qualified as admin" do
        user = FactoryGirl.create :user, :admin
        expect(user.admin?).to be_truthy
      end

      it "returns false if user has any role other than admin" do
        user = FactoryGirl.create :user, :consumer
        expect(user.admin?).to be_falsey
      end
    end

    describe "#client?" do
      it "returns true if user has role of client" do
        user = FactoryGirl.create :user, :client
        expect(user.client?).to be_truthy
      end

      it "returns false if user has any role other than client" do
        user = FactoryGirl.create :user, :admin
        expect(user.client?).to be_falsey
      end
    end

    describe "#consumer?" do
      it "returns true if user has role of consumer" do
        user = FactoryGirl.create :user, :consumer
        expect(user.consumer?).to be_truthy
      end

      it "returns false if user has any role other than consumer" do
        user = FactoryGirl.create :user, :admin
        expect(user.consumer?).to be_falsey
      end
    end

    describe "#basic?" do
      it "returns true if user has status of basic" do
        user = FactoryGirl.create :user, :client_basic
        expect(user.basic?).to be_truthy
      end

      it "returns true if user has status of premium" do
        user = FactoryGirl.create :user, :client_premium
        expect(user.basic?).to be_truthy
      end
    end

    describe "#pro?" do
      it "returns false if user has status of basic" do
        user = FactoryGirl.create :user, :client_basic
        expect(user.pro?).to be_falsey
      end

      it "returns true if user has status of premium" do
        user = FactoryGirl.create :user, :client_premium
        expect(user.pro?).to be_truthy
      end

      it "returns true if user has status of pro" do
        user = FactoryGirl.create :user, :client_pro
        expect(user.pro?).to be_truthy
      end
    end

    describe "#premium?" do
      it "returns false if user has status of basic" do
        user = FactoryGirl.create :user, :client_basic
        expect(user.premium?).to be_falsey
      end

      it "returns false if user has status of pro" do
        user = FactoryGirl.create :user, :client_pro
        expect(user.premium?).to be_falsey
      end

      it "returns true if user has status of premium" do
        user = FactoryGirl.create :user, :client_premium
        expect(user.premium?).to be_truthy
      end
    end

    describe "#active_admin_access?" do
      it "returns true if user has a role qualified for Active Admin access" do
        user = FactoryGirl.create :user, :admin
        expect(user.active_admin_access?).to be_truthy
      end

      it "returns true if user has any role qualified for Active Admin access" do
        user = FactoryGirl.create :user, :admin
        expect(user.active_admin_access?).to be_truthy
      end

      it "returns false if user has no role qualified for Active Admin access" do
        user_1 = FactoryGirl.create :user, :consumer
        user_2 = FactoryGirl.create :user, :client
        expect(user_1.active_admin_access?).to be_falsey
        expect(user_2.active_admin_access?).to be_falsey
      end
    end

    describe "#archived?" do
      it "sets archived as false by default" do
        user = FactoryGirl.create :user
        expect(user.archived?).to be_falsey
      end

      it "evaluates a user as archived" do
        user = FactoryGirl.create :user, archived: true
        expect(user.archived?).to be_truthy
      end

      it "evaluates a user as active" do
        user = FactoryGirl.create :user, archived: false
        expect(user.archived?).to be_falsey
      end

      it "evaluates a user as active if status is nil" do
        user = FactoryGirl.create :user, archived: nil
        expect(user.archived?).to be_falsey
      end
    end
  end

  describe "#archive" do
    it "sets the archived flag to true" do
      user = FactoryGirl.create :user
      user.archive
      expect(user.reload.archived).to be_truthy
    end
  end

  describe "#unarchive" do
    it "sets the archived flag to false" do
      user = FactoryGirl.create :user, archived: true
      user.unarchive
      expect(user.reload.archived).to be_falsey
    end
  end

  describe "#roles_presented" do
    it "sets the archived flag to false" do
      user = FactoryGirl.create :user, roles: [UserRoles::CONSUMER, UserRoles::CLIENT]
      expect(user.roles_presented).to eq "#{UserRoles::CONSUMER}, #{UserRoles::CLIENT}"
    end
  end

  it { is_expected.to have_many :activities }
  it { is_expected.to have_many :calendars }
  it { is_expected.to have_many :calendar_users }
  it { is_expected.to have_many :organizations }
  it { is_expected.to have_many :organization_users }
  it { is_expected.to have_many :favorited_events }
  it { is_expected.to have_many :authored_events }
  it { is_expected.to belong_to :location }
  it { is_expected.to have_one :region }
end
