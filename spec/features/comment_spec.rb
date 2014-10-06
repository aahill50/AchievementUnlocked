require 'spec_helper'
require 'rails_helper'

feature "create comments" do
    before(:each) do
      @goal_guy = create_user("foo", "bar")
      @comment_guy = create_user("foo2", "bar")

      login_user("foo", "bar")
      create_goal(@goal_guy, "public goal", "public goal description")
      @goal1 = @goal_guy.goals.first
      visit goal_url(@goal1)
      click_link "Edit Goal"
      choose "Public"
      click_on "Update Goal"
      click_on "Log out"
    end

  it "can comment on goals" do
    login_user("foo2","bar")
    visit goal_url(@goal1)
    fill_in "Comment", with: "Unique observation"
    click_on "Add Comment"
    expect(page).to have_content("Unique observation")
  end

  it "can comment on user pages" do
    login_user("foo2","bar")
    visit user_url(@goal_guy)
    fill_in "Comment", with: "Witty statement"
    click_on "Add Comment"
    expect(page).to have_content("Witty statement")
  end

  it "can't submit a blank comment" do
    login_user("foo2","bar")
    visit user_url(@goal_guy)
    click_on "Add Comment"
    expect(page).to have_content("can't be blank")
  end


end