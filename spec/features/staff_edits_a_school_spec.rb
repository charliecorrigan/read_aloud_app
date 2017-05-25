require 'rails_helper'

RSpec.describe "Staff edits a school" do
  it "they fill out edit school form" do
    staff = User.create(first_name: "Minerva",
                      last_name: "McGonagall",
                      active: true,
                      username: "mmcgonagall",
                      password: "supersecretpassword",
                      role: 1,
                      language: 0)
    school = School.create(name: "Hogwarts", address: "address unavailable")
    visit root
    fill_in "username", with: user.username
    fill_in "password", with: "supersecretpassword"
    click_on "Sign In"
    click_on "Manage"
    click_on "View Schools"
    click_button "Edit"
    fill_in "Address", with: "123 Wizard Way"
    click_on "Update School"
    expect(current_path).to eq(school_path(school))
    expect(page).to_not have_content("address unavailable")
    expect(page).to have_content("123 Wizard Way")
    expect(page).to have_content("Hogwarts")
  end