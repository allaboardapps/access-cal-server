require "rails_helper"

describe User, type: :model do
  it "has a valid factory" do
    expect(create :user).to be_valid
  end

  it "is invalid without an email address" do
    expect(build :user, password: nil).to_not be_valid
  end

  it "is invalid without a password" do
    expect(build :user, email: nil).to_not be_valid
  end

  it "is invalid without a sufficient password" do
    expect(build :user, password: "1234567").to_not be_valid
  end

  describe "#full_name" do
    it "renders the user first and last name separated by a space" do
      user = create(:user, first_name: "Bubba", last_name: "Jones")
      expect(user.full_name).to eq "#{user.first_name.capitalize} #{user.last_name.capitalize}"
    end

    it "capitalizes the user first and last names" do
      user = create(:user, first_name: "bubba", last_name: "jones")
      expect(user.full_name).to eq "#{user.first_name.capitalize} #{user.last_name.capitalize}"
    end

    it "capitalizes the user first name and trims any pre-fixed space" do
      user = create(:user, first_name: "bubba", last_name: "")
      expect(user.full_name).to eq "#{user.first_name.capitalize}"
    end

    it "capitalizes the user last name and trims any post-fixed space" do
      user = create(:user, first_name: "", last_name: "jones")
      expect(user.full_name).to eq "#{user.last_name.capitalize}"
    end

    context "nil names" do
      it "capitalizes the user last name and trims any post-fixed space" do
        user = create(:user, first_name: nil, last_name: "jones")
        expect(user.full_name).to eq "#{user.last_name.capitalize}"
      end

      it "capitalizes the user first name and trims any post-fixed space" do
        user = create(:user, first_name: "bubba", last_name: nil)
        expect(user.full_name).to eq "#{user.first_name.capitalize}"
      end

      it "returns a blank" do
        user = create(:user, first_name: nil, last_name: nil)
        expect(user.full_name).to eq ""
      end
    end

    describe "#first_name_abbreviated" do
      it "renders the user first name abbreviated with period, last name by seven characters" do
        user = create(:user, first_name: "Bubba", last_name: "Schemmel")
        expect(user.first_name_abbreviated).to eq "B. Schemme"
      end

      it "renders the user first name abbreviated with period, last name by seven or less chars" do
        user = create(:user, first_name: "Mark", last_name: "Smith")
        expect(user.first_name_abbreviated).to eq "M. Smith"
      end

      it "renders the user first abbreviated by a single character and last name by argument" do
        user = create(:user, first_name: "Bubba", last_name: "Jones-Smitherwich")
        expect(user.first_name_abbreviated(10)).to eq "B. Jones-Smit"
      end
    end

    describe "#last_name_abbreviated" do
      it "renders the user first name by seven characters, last name abbreviated with period" do
        user = create(:user, first_name: "Bubbalicious", last_name: "Schemmel")
        expect(user.last_name_abbreviated).to eq "Bubbali S."
      end

      it "renders the user first name by seven or less chars, last name abbreviated with period" do
        user = create(:user, first_name: "Mark", last_name: "Smith")
        expect(user.last_name_abbreviated).to eq "Mark S."
      end

      it "renders the user first abbreviated by a single character and last name by argument" do
        user = create(:user, first_name: "Bubbalicious", last_name: "Jones-Smitherwich")
        expect(user.last_name_abbreviated(14)).to eq "Bubbalicious J."
      end
    end

    describe "#admin?" do
      it "returns true if user has a role qualified as admin" do
        user = create :user, :admin
        expect(user.admin?).to be_truthy
      end

      it "returns false if user has any role other than admin" do
        user = create :user, :customer
        expect(user.admin?).to be_falsey
      end
    end

    describe "#client?" do
      it "returns true if user has role of client" do
        user = create :user, :client
        expect(user.client?).to be_truthy
      end

      it "returns false if user has any role other than client" do
        user = create :user, :admin
        expect(user.client?).to be_falsey
      end
    end

    describe "#customer?" do
      it "returns true if user has role of customer" do
        user = create :user, :customer
        expect(user.customer?).to be_truthy
      end

      it "returns false if user has any role other than customer" do
        user = create :user, :admin
        expect(user.customer?).to be_falsey
      end
    end

    describe "#basic?" do
      it "returns true if user has status of basic" do
        user = create :user, :customer, :basic
        expect(user.basic?).to be_truthy
      end

      it "returns true if user has status of premium" do
        user = create :user, :customer, :premium
        expect(user.basic?).to be_truthy
      end
    end

    describe "#pro?" do
      it "returns false if user has status of basic" do
        user = create :user, :customer, :basic
        expect(user.pro?).to be_falsey
      end

      it "returns true if user has status of premium" do
        user = create :user, :customer, :premium
        expect(user.pro?).to be_truthy
      end

      it "returns true if user has status of pro" do
        user = create :user, :customer, :pro
        expect(user.pro?).to be_truthy
      end
    end

    describe "#premium?" do
      it "returns false if user has status of basic" do
        user = create :user, :customer, :basic
        expect(user.premium?).to be_falsey
      end

      it "returns false if user has status of pro" do
        user = create :user, :customer, :pro
        expect(user.premium?).to be_falsey
      end

      it "returns true if user has status of premium" do
        user = create :user, :customer, :premium
        expect(user.premium?).to be_truthy
      end
    end

    describe "#active_admin_access?" do
      it "returns true if user has a role qualified for Active Admin access" do
        user = create :user, :admin
        expect(user.active_admin_access?).to be_truthy
      end

      it "returns true if user has any role qualified for Active Admin access" do
        user = create :user, :admin
        expect(user.active_admin_access?).to be_truthy
      end

      it "returns false if user has no role qualified for Active Admin access" do
        user_1 = create :user, :customer
        user_2 = create :user, :client
        expect(user_1.active_admin_access?).to be_falsey
        expect(user_2.active_admin_access?).to be_falsey
      end
    end

    describe "#archived?" do
      it "sets archived as false by default" do
        user = create :user
        expect(user.archived?).to be_falsey
      end

      it "evaluates a user as archived" do
        user = create :user, archived: true
        expect(user.archived?).to be_truthy
      end

      it "evaluates a user as active" do
        user = create :user, archived: false
        expect(user.archived?).to be_falsey
      end

      it "evaluates a user as active if status is nil" do
        user = create :user, archived: nil
        expect(user.archived?).to be_falsey
      end
    end
  end

  describe "#archive" do
    it "sets the archived flag to true" do
      user = create :user
      user.archive
      expect(user.reload.archived).to be_truthy
    end
  end

  describe "#unarchive" do
    it "sets the archived flag to false" do
      user = create :user, archived: true
      user.unarchive
      expect(user.reload.archived).to be_falsey
    end
  end

  describe "#roles_presented" do
    it "sets the archived flag to false" do
      user = create :user, roles: [UserRoles::CUSTOMER, UserRoles::CLIENT]
      expect(user.roles_presented).to eq "#{UserRoles::CUSTOMER}, #{UserRoles::CLIENT}"
    end
  end

  it { is_expected.to have_many :favorited_events }
  it { is_expected.to have_many :owned_events }
  it { is_expected.to belong_to :location }
  it { is_expected.to have_one :region }
end
