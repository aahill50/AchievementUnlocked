require 'spec_helper'
require 'rails_helper'

feature "create goals" do

  before :each do
    @user = create_and_login_one_user
  end

  it "should be able to create a goal" do
    visit new_user_goal_url(@user)
    fill_in "Title", :with => "learn to swim"
    fill_in "Description", :with => "I don't like to drown"
    click_on "Create Goal"
    expect(page).to have_content("learn to swim")
  end

end