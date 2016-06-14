require "rails_helper"

describe "visiting active admin dashboard", type: :feature do
  it "receives a routing error if user is not an admin" do
    user = FactoryGirl.create :user, :consumer
    visit new_user_session_path
    fill_in :user_email, with: user.email
    fill_in :user_password, with: user.password
    click_on "Sign in"
    visit admin_dashboard_path
    # expect { visit admin_dashboard_path }.to raise_error :access_denied
    expect(page.status_code).to eq :access_denied
  end

  it "does not receive a routing error if user is an admin" do
    user = FactoryGirl.create :user, :admin
    visit new_user_session_path
    fill_in :user_email, with: user.email
    fill_in :user_password, with: user.password
    click_on "Sign in"
    expect { visit admin_dashboard_path }.not_to raise_error
    expect(page.status_code).to eq 200
  end
end
