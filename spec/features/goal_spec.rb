require 'spec_helper'
require 'rails_helper'

feature "create goals" do

  before :each do
    @user = create_user("foo", "password")
  end

  it "should be able to create a goal" do
    login_user("foo", "password")
    visit new_user_goal_url(@user)
    fill_in "Title", :with => "learn to swim"
    fill_in "Description", :with => "I don't like to drown"
    click_on "Create Goal"
    expect(page).to have_content("learn to swim")
  end

  it "should not be able to create a goal if not logged in" do
    visit new_user_goal_url(@user)
    expect(page).to have_content("Log in")
  end

  it "should require a title" do
    login_user("foo", "password")
    visit new_user_goal_url(@user)
    fill_in "Description", :with => "I don't like to drown"
    click_on "Create Goal"
    expect(page).to have_content("can't be blank")
  end
end

feature "edit goals" do
  before :each do
    @user = create_user("foo", "password")
    login_user("foo", "password")
    create_goal(@user, "learn to swim", "I don't want to drown")
  end

  it "should be able to edit goals" do
    goal = @user.goals.first
    visit goal_url(goal)
    click_link "Edit Goal"
    fill_in "Title", :with => "learn to float"
    click_on "Update Goal"
    expect(page).to have_content("learn to float")
  end

  it "should be able to mark a goal as public" do
    goal = @user.goals.first
    visit goal_url(goal)
    click_link "Edit Goal"
    choose "Public"
    click_on "Update Goal"
    expect(page).to have_content("Public")
  end

  it "should be able to mark a goal as completed" do
    goal = @user.goals.first
    visit goal_url(goal)
    click_link "Edit Goal"
    check "Completed?"
    click_on "Update Goal"
    expect(page).to have_content("COMPLETE!")
  end

  it "shouldn't be able to edit another user's goal" do
    click_on "Log out"
    user2 = create_user("foo2", "password")
    login_user("foo2", "password")
    visit edit_goal_url(@user.goals.first)
    expect(page).to_not have_content("Update")
  end
end

feature "viewing user goals" do
  before(:each) do
    @user1 = create_user("foo", "bar")
    @user2 = create_user("foo2", "bar")

    login_user("foo", "bar")
    create_goal(@user1, "public goal", "public goal description")
    create_goal(@user1, "private goal", "private goal description")
    goal = @user1.goals.first
    visit goal_url(goal)
    click_link "Edit Goal"
    choose "Public"
    click_on "Update Goal"
    click_on "Log out"
  end


  it "should view public and prviate goals on their own page" do
    login_user("foo", "bar")
    visit user_url(@user1)
    expect(page).to have_content("private goal")
  end

  it "should not view another user's private goals" do
    login_user("foo2", "bar")
    visit user_url(@user1)
    expect(page).to_not have_content("private goal")
  end
end

feature "deleting goals" do
  before(:each) do
    @user1 = create_user("foo", "bar")
    @user2 = create_user("foo2", "bar")

    login_user("foo", "bar")
    create_goal(@user1, "public goal", "public goal description")
    create_goal(@user1, "private goal", "private goal description")
    goal = @user1.goals.first
    visit goal_url(goal)
    click_link "Edit Goal"
    choose "Public"
    click_on "Update Goal"
    click_on "Log out"
  end

  it "should be able to delete their own goals" do
    login_user("foo", "bar")
    visit goal_url(@user1.goals.first)
    click_on "Delete Goal"
    expect(page).to_not have_content("public goal")
  end

  it "should not be able to delete someone elses goals" do
    login_user("foo2", "bar")
    visit goal_url(@user1.goals.first)
    expect(page).to_not have_button("Delete Goal")
  end
end

