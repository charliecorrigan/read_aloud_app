require 'rails_helper'

RSpec.describe "User visits login page" do
  it "can log in" do
    user = User.create(first_name: "Hermione",
                      last_name: "Granger",
                      active: true,
                      username: "hgranger",
                      password: "supersecretpassword",
                      role: 0,
                      language: 0)
    visit login_path
    fill_in "username", with: user.username
    fill_in "password", with: "supersecretpassword"
    click_on "Sign In"

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content("Welcome, Hermione")
    expect(page).to have_content("Read")
    expect(page).to have_content("Profile")
    expect(page).to have_content("Sign Out")
  end
end


