require "rails_helper"

describe "checking basic stability of resources", type: :feature do
  let(:consumer) { FactoryGirl.create :user, :consumer }

  def log_in_with(email, password)
    visit new_user_session_path
    fill_in "Email", with: email
    fill_in "Password", with: password
    click_button "Sign in"
  end

  describe "loading static pages" do
    it "visits the home page and is redirected to the sign_in page" do
      visit root_path
      expect(page.source).to have_css "body"
    end

    it "visits the home page as an" do
      log_in_with consumer.email, consumer.password
      visit root_path
      expect(page.source).to have_css "body.static.home"
    end
  end
end
