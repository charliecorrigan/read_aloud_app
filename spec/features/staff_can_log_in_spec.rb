require 'rails_helper'

RSpec.describe "Staff visits login page" do
  it "has account and can log in" do
    staff = User.create(first_name: "Minerva",
                      last_name: "McGonagall",
                      username: "mmcgonagall",
                      password: "supersecretpassword",
                      role: 1,
                      language: 0)
    visit login_path
    fill_in "Username", with: staff.username
    fill_in "Password", with: "supersecretpassword"
    click_on "Sign In"

    expect(current_path).to eq(user_path(staff))
    expect(page).to have_content("Welcome, Minerva")
    expect(page).to have_content("Read")
    expect(page).to have_content("Profile")
    expect(page).to have_content("View My Events")
    expect(page).to have_content("Manage")
    expect(page).to have_content("Sign Out")
  end

  xit "has no account and can't log in" do
    visit root_path
    fill_in "Username", with: "lmalfoy"
    fill_in "Password", with: "iamthebest"
    click_on "Sign In"

    expect(current_path).to eq(root_path)
#------------UNSURE OF ERROR WORDING
    expect(current_path).to have_content("The username or password you entered doesn't match our records")
  end

  xit "has account but enters wrong password" do
    staff = User.create(first_name: "Minerva",
                      last_name: "McGonagall",
                      username: "mmcgonagall",
                      password: "supersecretpassword",
                      role: 1,
                      language: 0)
    visit root_path
    fill_in "Username", with: user.username
    fill_in "Password", with: "thisisthewrongpassword"
    click_on "Sign In"

    expect(current_path).to eq(root_path)
#------------UNSURE OF ERROR WORDING
    expect(current_path).to have_content("The username or password you entered doesn't match our records")
  end

  xit "has account but enters wrong username" do
    staff = User.create(first_name: "Minerva",
                      last_name: "McGonagall",
                      username: "mmcgonagall",
                      password: "supersecretpassword",
                      role: 1,
                      language: 0)
    visit root_path
    fill_in "Username", with: "grangerh"
    fill_in "Password", with: "supersecretpassword"
    click_on "Sign In"

    expect(current_path).to eq(root_path)
    expect(current_path).to have_content("The username or password you entered doesn't match our records")
  end
end