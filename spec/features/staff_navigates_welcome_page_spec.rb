require 'rails_helper'

RSpec.describe "Staff navigates through their welcome page" do
  it "they click on Read" do
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
    click_on "Read"

    expect(current_path).to eq(new_user_event_path(staff))
  end

  it "they click on History" do
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
    click_on "History"

    expect(current_path).to eq(user_events_path(staff))
  end

  it "they click on Profile" do
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
    click_on "Profile"

    expect(current_path).to eq(user_events_path(staff))
  end

  it "they click on Manage" do
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
    click_on "Manage"

    expect(current_path).to eq(login_path)
  end

  it "they click on Sign Out" do
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
    click_on "Sign Out"

    expect(current_path).to eq(login_path)
  end
end