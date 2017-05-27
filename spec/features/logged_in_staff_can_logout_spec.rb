require 'rails_helper'

RSpec.describe "Logged in staff clicks sign out" do
  it "they successfully sign out" do
    staff = User.create(first_name: "Minerva",
                      last_name: "McGonagall",
                      active: true,
                      username: "mmcgonagall",
                      password: "supersecretpassword",
                      role: 1,
                      language: 0)
    visit root
    fill_in "username", with: staff.username
    fill_in "password", with: "supersecretpassword"
    click_on "Sign In"
    click_on "Sign Out"

    expect(current_path).to eq(root)
    expect(page).to have_content("Sign In")
    expect(page).to_not have_content("Minerva")
  end
end