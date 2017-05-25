require 'rails_helper'

RSpec.describe "Staff visits schools index" do
  it "they see all schools" do
    staff = User.create(first_name: "Minerva",
                      last_name: "McGonagall",
                      active: true,
                      username: "mmcgonagall",
                      password: "supersecretpassword",
                      role: 1,
                      language: 0)
    school = School.create(name: "Hogwarts", address: "123 Wizard Way")
    visit root
    fill_in "username", with: staff.username
    fill_in "password", with: "supersecretpassword"
    click_on "Sign In"
    click_on "Manage"
    click_on "View Schools"

    expect(current_path).to eq(schools_path)
    expect(page).to have_content("123 Wizard Way")
    expect(page).to have_content("Hogwarts")
  end