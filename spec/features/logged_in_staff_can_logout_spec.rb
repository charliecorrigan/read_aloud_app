require 'rails_helper'

RSpec.describe "Logged in staff clicks sign out" do
  it "they successfully sign out" do
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
    expect(page).to have_button("Sign In")
    expect(page).to_not have_content("Minerva")
  end
end