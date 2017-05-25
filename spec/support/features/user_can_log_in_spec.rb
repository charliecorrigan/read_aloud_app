require 'rails_helper'

RSpec.describe "User visits login page" do
  it "has account and can log in" do
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

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content("Welcome, Hermione")
    expect(page).to have_content("Read")
    expect(page).to have_content("Profile")
    expect(page).to have_content("Sign Out")
  end

  it "has no account and can't log in" do
    visit root
    fill_in "username", with: "John Snow"
    fill_in "password", with: "youknownothing"
    click_on "Sign In"

    expect(current_path).to eq(root_path)
#------------UNSURE OF ERROR WORDING
    expect(current_path).to have_content("The username or password you entered doesn't match our records")
  end

  it "has account but enters wrong password" do
    user = User.create(first_name: "Hermione",
                      last_name: "Granger",
                      active: true,
                      username: "hgranger",
                      password: "supersecretpassword",
                      role: 0,
                      language: 0)
    visit root
    fill_in "username", with: user.username
    fill_in "password", with: "thisisthewrongpassword"
    click_on "Sign In"

    expect(current_path).to eq(root_path)
#------------UNSURE OF ERROR WORDING
    expect(current_path).to have_content("The username or password you entered doesn't match our records")
  end

it "has account but enters wrong username" do
    user = User.create(first_name: "Hermione",
                      last_name: "Granger",
                      active: true,
                      username: "hgranger",
                      password: "supersecretpassword",
                      role: 0,
                      language: 0)
    visit root
    fill_in "username", with: "grangerh"
    fill_in "password", with: "supersecretpassword"
    click_on "Sign In"

    expect(current_path).to eq(root_path)
#------------UNSURE OF ERROR WORDING
    expect(current_path).to have_content("The username or password you entered doesn't match our records")
  end
end


