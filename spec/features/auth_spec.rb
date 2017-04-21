require 'rails_helper'
require 'spec_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Sign up"
    expect(page).to have_content "Username"
    expect(page).to have_content "Password"
  end

  feature "signing up a user" do

    before(:each) do
      visit new_user_url
      fill_in "Username", with: "test_name"
      fill_in "Password", with: "password"
      click_on "Sign up"
    end

    scenario "shows username on the homepage after signup" do
      expect(page).to have_content("Welcome test_name")
      expect(page).to have_content("Test_name's Profile")
    end
  end
end

feature "logging in" do

  scenario "begins with a logged out state" do
    visit users_url
    expect(page).to have_content("Sign Up")
    expect(page).to have_content("Log In")
  end

  scenario "doesn't show username on the homepage after logout" do
    visit new_user_url
    fill_in "Username", with: "test_name"
    fill_in "Password", with: "password"
    click_on "Sign up"
    click_on "Log Out"

    expect(page).to_not have_content("Log Out")

  end

end
