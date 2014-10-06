require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content("Sign up")
  end

  feature "signing up a user" do
    it "shows username on the homepage after signup" do
      visit new_user_url
      fill_in 'username', with: "FOO"
      fill_in 'password', with: "password"
      click_on "Sign up"

      expect(page).to have_content("FOO")
      expect(page).to have_content("Welcome")
    end
  end
end

feature "logging in" do

  before :each do
    User.create(username: "foo", password: "password")
  end

  it "shows username on the homepage after login" do
    visit new_session_url
    fill_in 'username', with: "foo"
    fill_in 'password', with: "password"
    click_on "Log in"

    expect(page).to have_content("foo")
  end
end

feature "logging out" do
  it "beings with logged out state" do
    visit users_url
    expect(page).to have_content("Log in")
  end

  it "doesn't show username on the homepage after logout" do
    User.create(username: "foo", password: "password")

    visit new_session_url
    fill_in 'username', with: "foo"
    fill_in 'password', with: "password"
    click_on "Log in"

    click_on "Log out"
    expect(page).to have_content("Log in")
  end
end