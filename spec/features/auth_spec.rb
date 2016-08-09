require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New User"
  end

  feature "signing up a user" do
    before(:each) do
      visit new_user_url
      fill_in 'username', with: "testname"
      fill_in 'password', with: "password"
      click_on "Create User"
    end

    scenario "shows username on the homepage after signup" do
      expect(page).to have_content "testname"
    end
  end

end

feature "logging in" do
  let!(:user) do
    User.create(username: "testname", password: "password")
  end
  before(:each) do
    visit new_session_url
    fill_in 'username', with: "testname"
    fill_in 'password', with: "password"
    click_on "Login User"
  end
  scenario "shows username on the homepage after login" do
    expect(page).to have_content "testname"
  end

end

feature "logging out" do

  let!(:user) do
    User.create(username: "testname", password: "password")
  end

  before(:each) do
    visit new_session_url
    fill_in 'username', with: "testname"
    fill_in 'password', with: "password"
    click_on "Login User"
    visit goals_url
    click_on "Logout"
  end

  scenario "begins with a logged out state" do
    expect(page).to have_content "Sign In"
  end

  scenario "doesn't show username on the homepage after logout" do
    expect(page).not_to have_content "testname"
  end

end
