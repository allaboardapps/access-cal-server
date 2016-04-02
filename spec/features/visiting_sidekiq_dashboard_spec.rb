require "rails_helper"

describe "visiting sidekiq dashboard", type: :feature do

  it "receives a routing error if user is not an admin" do
    user = FactoryGirl.create :user, :consumer
    visit new_user_session_path
    fill_in :user_email, with: user.email
    fill_in :user_password, with: user.password
    click_on "Log in"
    expect{ visit sidekiq_web_path }.to raise_error(ActionController::RoutingError)
  end

  it "does not receive a routing error if user is an admin" do
    user = FactoryGirl.create :user, :admin
    visit new_user_session_path
    fill_in :user_email, with: user.email
    fill_in :user_password, with: user.password
    click_on "Log in"
    expect{ visit sidekiq_web_path }.not_to raise_error
  end
end
