require 'rails_helper'

RSpec.describe "User visits new event page" do
  it "they fill out event form" do
    user = User.create(first_name: "Hermione",
                      last_name: "Granger",
                      active: true,
                      username: "hgranger",
                      password: "supersecretpassword",
                      role: 0,
                      language: 0)
    visit root
    fill_in "username", with: user.username
    fill_in "password", with: "supersecretpassword"
    click_on "Sign In"
    click_on "Read"
    #------------------------------------------------
    # Unsure of classroom/school/grade dropdown setup
    #------------------------------------------------
    fill_in "How many kids", with: 18
    fill_in "How many adults", with: 3
    fill_in "How many minutes", with: 20
    click_on "Next"
    #------------------------------------------------
    # Will this create a new event?
    # Will users confirm BEFORE creating? (before_action will redirect to confirmation)
    # If users can edit -- probably just create with no confirmation
    #------------------------------------------------

    #expect(current_path).to eq(new_user_event_path(user))
  end