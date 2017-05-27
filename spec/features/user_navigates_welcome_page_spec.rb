require 'rails_helper'

RSpec.describe "User navigates welcome page" do
  it "they click on Read" do
    user = User.create(first_name: "Hermione",
                      last_name: "Granger",
                      username: "hgranger",
                      password: "supersecretpassword",
                      role: 0,
                      language: 0)
    visit login_path
    fill_in "Username", with: user.username
    fill_in "Password", with: "supersecretpassword"
    click_on "Sign In"
    click_on "Read"

    expect(current_path).to eq(new_user_event_path(user))
  end

  it "they click on History" do
    user = User.create(first_name: "Hermione",
                      last_name: "Granger",
                      username: "hgranger",
                      password: "supersecretpassword",
                      role: 0,
                      language: 0)
    visit login_path
    fill_in "Username", with: user.username
    fill_in "Password", with: "supersecretpassword"
    click_on "Sign In"
    click_on "History"

    expect(current_path).to eq(user_events_path(user))
  end

  it "they click on Sign Out" do
    user = User.create(first_name: "Hermione",
                      last_name: "Granger",
                      username: "hgranger",
                      password: "supersecretpassword",
                      role: 0,
                      language: 0)
    visit login_path
    fill_in "Username", with: user.username
    fill_in "Password", with: "supersecretpassword"
    click_on "Sign In"
    click_on "Sign Out"

    expect(current_path).to eq(login_path)
  end
end