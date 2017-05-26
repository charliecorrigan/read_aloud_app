require 'rails_helper'

RSpec.describe "Staff visits sign in page" do
  it "has account and can sign in" do
    staff = User.create(first_name: "Minerva",
                      last_name: "McGonagall",
                      username: "mmcgonagall",
                      password: "supersecretpassword",
                      role: 1,
                      language: 0)
    visit login_path
    fill_in "Username", with: staff.username
    fill_in "Password", with: "supersecretpassword"

    click_button "Sign In"
    expect(current_path).to eq(user_path(staff))
    expect(page).to have_content("Welcome, Minerva")
    expect(page).to have_content("Read")
    expect(page).to have_content("Profile")
    expect(page).to have_content("View My Events")
    expect(page).to have_content("Manage")
    expect(page).to have_content("Sign Out")
  end
end

